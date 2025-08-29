class HomeController < ApplicationController
  def index
  end

  def standards
    @standards = Evaluation.new.tap(&:initialize_with_latest_standards).questions.group_by(&:category)
  end
end
