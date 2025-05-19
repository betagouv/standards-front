class AuditsController < ApplicationController
  before_action :authenticate_user!, :set_startup

  before_action :set_audit, only: %i[show update category question]
  before_action :set_category, only: %i[category update question]

  before_action :set_startup_breadcrumb
  before_action :set_audit_breadcrumb, only: %i[show category question]
  before_action :set_category_breadcrumb, only: %i[category question]

  def show; end

  def update
    update_audit_with_params(@audit, audit_params)

    if @audit.save
      redirect_to after_update_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def category; end

  def question
    @question = @audit.questions.find { |q| q.id == params[:question] }
    @next_question = find_next_question(@question)

    add_breadcrumb(@question.title.truncate(42))
  end

  private

  def after_update_path
    question = find_params_question(audit_params)

    if goto_next_question?
      next_question = find_next_question(question)

      category_question_startup_audit_path(@startup.ghid, next_question.category, next_question.id)
    else
      category_startup_audit_path(@startup.ghid, question.category)
    end
  end

  def goto_next_question?
    params[:commit] =~ /suivante/
  end

  def find_next_question(question)
    @audit.next_question_after(question)
  end

  def set_startup
    @startup = current_user.active_startups.find_by(ghid: params["startup_ghid"])
  end

  def set_audit
    @audit = @startup.audit || Audit.find_or_initialize_by(startup: @startup) do |audit|
      audit.initialize_with_latest_standards
    end.tap(&:save)
  end

  def set_category
    @category = params[:category]
  end

  def set_audit_breadcrumb
    add_breadcrumb("Audit du produit #{@startup.name}", startup_audit_path(@startup.ghid))
  end

  def set_startup_breadcrumb
    add_breadcrumb("Startups", startups_path)
  end

  def set_category_breadcrumb
    add_breadcrumb(@category.humanize, category_startup_audit_path(@startup.ghid, @category))
  end

  def audit_params
    params
      .require(:audit)
      .permit(audit_question: [ :id, criteria: {} ])
  end

  def update_audit_with_params(audit, audit_params)
    return if audit_params["audit_question"]["criteria"].nil?

    question = find_params_question(audit_params)
    criteria = audit_params["audit_question"]["criteria"]

    question.criteria.each_with_index do |criterion, index|
      question.criteria[index].answer = criteria[index.to_s]["answer"]
    end
  end

  def find_params_question(audit_params)
    @audit
      .questions
      .find { |question| question.id == audit_params["audit_question"]["id"] }
  end
end
