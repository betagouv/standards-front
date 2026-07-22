class IncubatorsController < ApplicationController
  # FIXME: must we authenticate the user?
  before_action :authenticate_user!

  def index
    @startups = EspaceMembre::Startup.active.includes(:incubator, :evaluation)

    @incubators = @startups.group_by(&:incubator).sort_by { |incub, _startups| incub.ghid.downcase }
  end

  def show
    @incubator = EspaceMembre::Incubator.find_by!(ghid: params[:ghid])

    @startups = @incubator
                  .startups
                  .active
                  .sort_by(&:name)

    add_breadcrumb("Tous les incubateurs", incubators_path)
    add_breadcrumb(@incubator.title)
  end
end
