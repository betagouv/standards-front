class AuditsController < ApplicationController
  before_action :set_startup, :set_breadcrumbs

  def show
  end

  def edit
    @audit = Audit.find_or_create_by(startup: @startup) do |audit|
      audit.data = Audit.latest
    end
  end

  private

  def set_startup
    @startup = current_user.active_startups.find(params["startup_id"])
  end

  def set_breadcrumbs
    add_breadcrumb("Startups", startups_index_path)
    add_breadcrumb(@startup.name)
  end
end
