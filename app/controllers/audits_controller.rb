class AuditsController < ApplicationController
  before_action :authenticate_user!, :set_startup, :set_breadcrumbs

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

  private

  def set_startup
    @startup = current_user.active_startups.find_by(ghid: params["startup_ghid"])
  end

  def set_breadcrumbs
    add_breadcrumb("Startups", startups_index_path)
    add_breadcrumb(@startup.name)
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
