class IncubatorsController < ApplicationController
  # FIXME: must we authenticate the user?
  before_action :authenticate_user!

  def index
    @incubators = EspaceMembre::Incubator
                    .includes(startups: :phases)
                    .order(:ghid)
                    .reject { |i| i.startups.active.none? } # FIXME: this triggers a bunch of queries
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
