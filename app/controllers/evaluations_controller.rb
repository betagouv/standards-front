class EvaluationsController < ApplicationController
  before_action :authenticate_user!, :set_startup

  before_action :set_evaluation, only: %i[show update category question]
  before_action :set_category, only: %i[category update question]

  before_action :set_startup_breadcrumb
  before_action :set_evaluation_breadcrumb, only: %i[show category question]
  before_action :set_category_breadcrumb, only: %i[category question]

  def show; end

  def update
    update_evaluation_with_params(@evaluation, evaluation_params)

    if @evaluation.save
      redirect_to after_update_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def category; end

  def question
    @question = @evaluation.questions.find { |q| q.id == params[:question] }

    add_breadcrumb(@question.title.truncate(42))
  end

  private

  def after_update_path
    question = find_params_question(evaluation_params)

    category_startup_evaluation_path(@startup.ghid, question.category)
  end

  def set_startup
    @startup = current_user.active_startups.find_by(ghid: params["startup_ghid"])
  end

  def set_evaluation
    @evaluation =
      @startup.evaluation ||
      Evaluation.from_latest_standards.tap { |e| e.update!(startup: @startup) }
  end

  def set_category
    @category = params[:category]
  end

  def set_evaluation_breadcrumb
    add_breadcrumb("Évaluation du produit #{@startup.name}", startup_evaluation_path(@startup.ghid))
  end

  def set_startup_breadcrumb
    add_breadcrumb("Vos services", startups_path)
  end

  def set_category_breadcrumb
    add_breadcrumb(
      t("evaluations.categories.#{@category}"),
      category_startup_evaluation_path(@startup.ghid, @category)
    )
  end

  def evaluation_params
    params
      .require(:evaluation)
      .permit(evaluation_question: [ :id, criteria: {} ])
  end

  def update_evaluation_with_params(evaluation, evaluation_params)
    return if evaluation_params["evaluation_question"]["criteria"].nil?

    question = find_params_question(evaluation_params)
    criteria = evaluation_params["evaluation_question"]["criteria"]

    question.criteria.each_with_index do |criterion, index|
      next if criteria[index.to_s].nil? # a criteria within the set isn't always answered

      question.criteria[index].answer = criteria[index.to_s]["answer"]
    end
  end

  def find_params_question(evaluation_params)
    @evaluation
      .questions
      .find { |question| question.id == evaluation_params["evaluation_question"]["id"] }
  end
end
