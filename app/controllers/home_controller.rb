class HomeController < ApplicationController
  def index
  end

  def standards
    @standards = Audit.new.tap(&:initialize_with_latest_standards).questions.group_by(&:category)
  end
end
