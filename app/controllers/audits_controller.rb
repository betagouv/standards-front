class AuditsController < ApplicationController
  before_action :authenticate_user!, :set_startup, :set_breadcrumbs

  def new
    @audit = Audit.new(startup: @startup).tap(&:initialize_with_latest_standards)
  end

  def edit
    @audit = Audit.find_or_initialize_by(startup: @startup)
  end


  def update
    @audit = Audit.find_or_initialize_by(startup: @startup)

    respond_to do |format|
      format.json { render json: { success: true } }
      format.html { redirect_to edit_startup_audit_path(@startup.ghid) }
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
end
