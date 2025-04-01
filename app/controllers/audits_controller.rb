class AuditsController < ApplicationController
  before_action :set_startup

  def show
  end

  private

  def set_startup
    @startup = current_user.active_startups.find(params["startup_id"])
  end
end
