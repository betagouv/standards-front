class AuditsController < ApplicationController
  before_action :authenticate_user!, :set_startup, :set_breadcrumbs
  before_action :load_latest_standards, only: %i[new edit]

  def new
    @audit = Audit.new(startup: @startup).tap(&:initialize_data)
  end

  def edit
    @audit = Audit.find_or_initialize_by(startup: @startup)
  end


  def update
    @audit = Audit.find_or_initialize_by(startup: @startup)

    # Initialize data if it's a new record
    if @audit.new_record?
      @audit.initialize_data
      @audit.save
    end

    category = params[:category]
    criterion_id = params[:criterion_id]
    status = params["criterion_#{criterion_id}"]

    @audit.update_criterion_status(category, criterion_id, status)

    respond_to do |format|
      format.json { render json: { success: true } }
      format.html { redirect_to edit_startup_audit_path(@startup) }
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

  def load_latest_standards
    @standards = Audit.latest
  end
end
