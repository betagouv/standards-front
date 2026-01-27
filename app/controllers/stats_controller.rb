class StatsController < ApplicationController
  def index
    @evaluations = Evaluation.all.map(&:presented)
  end
end
