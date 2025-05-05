class AuditsController < ApplicationController
  before_action :authenticate_user!, :set_startup

  before_action :set_audit, only: %i[edit update category question]
  before_action :set_category, only: %i[category question]

  before_action :set_startup_breadcrumb
  before_action :set_audit_breadcrumb, only: %i[edit category question]
  before_action :set_category_breadcrumb, only: %i[category question]

  def edit
    @audit = Audit.find_or_initialize_by(startup: @startup) do |audit|
      audit.initialize_with_latest_standards
    end.tap(&:save)
  end

  def update
    update_audit_with_params(@audit, audit_params)

    question = find_params_question(audit_params)

    if @audit.save
      respond_to do |format|
        format.json { render json: { success: true } }
        format.html { redirect_to category_startup_audit_path(@startup.ghid, question.category) }
      end
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @audit.errors, status: :unprocessable_entity }
    end
  end

  def category
  end

  def question
    @category = params[:category]
    @question = @audit.questions.find { |q| q.id == params[:question] }

    add_breadcrumb(@question.title.truncate(42))
  end

  private

  def set_startup
    @startup = current_user.active_startups.find_by(ghid: params["startup_ghid"])
  end

  def set_audit
    @audit = @startup.audit
  end

  def set_category
    @category = params[:category]
  end

  def set_audit_breadcrumb
    add_breadcrumb("Audit du produit #{@startup.name}", edit_startup_audit_path(@startup.ghid))
  end

  def set_startup_breadcrumb
    add_breadcrumb("Startups", startups_index_path)
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
