class HomeController < ApplicationController
  def index
  end

  def standards
    @standards = Evaluation.from_latest_standards.questions.group_by(&:category)
  end
end
