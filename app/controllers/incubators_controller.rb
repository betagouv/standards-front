class IncubatorsController < ApplicationController
  # FIXME: must we authenticate the user?
  before_action :authenticate_user!

  def index
    @incubators = EspaceMembre::Incubator
                    .includes(startups: :latest_phase)
                    .sort_by { |i| i.ghid.downcase }
                    .reject { |i| i.startups.active.none? }
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
