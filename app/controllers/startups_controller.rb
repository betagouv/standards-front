class StartupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @startups = current_user.active_startups.sort_by(&:name)
  end
end
