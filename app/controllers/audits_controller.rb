class AuditsController < ApplicationController
  before_action :authenticate_user!, :set_startup

  before_action :set_audit, only: %i[edit category question]
  before_action :set_category, only: %i[category question]

  before_action :set_startup_breadcrumb
  before_action :set_audit_breadcrumb, only: %i[edit category question]
  before_action :set_category_breadcrumb, only: %i[category question]

  def new
    @audit = Audit.new(startup: @startup).tap(&:initialize_with_latest_standards).tap(&:save)
  end

  def edit
    @audit = Audit.find_or_initialize_by(startup: @startup)
  end

  def update
    @audit = Audit.find_by!(startup: @startup)

    @audit.questions = merge_audit_params(@audit, audit_params)

    if @audit.save
      respond_to do |format|
        format.json { render json: { success: true } }
        format.html { redirect_to edit_startup_audit_path(@startup.ghid) }
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
      .permit(questions: {})
  end

  def merge_audit_params(audit, data)
    question_params = data["questions"]

    audit.questions.each do |question|
      answer = question_params[question.id]

      next if answer.blank?

      answer["criteria"].each.with_index do |answer, index|
        question.criteria[index].answer = answer
      end
    end
  end
end
