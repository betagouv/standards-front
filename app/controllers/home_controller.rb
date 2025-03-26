class HomeController < ApplicationController
  before_action :check_existing_survey, except: :welcome

  def index
    @questions ||= YAML.safe_load_file("config/standards-beta.yml")
  end

  def welcome
    @products = Startup.pluck(:name)
  end

  private

  def check_existing_survey
    if session[:survey_id].blank?
      redirect_to action: :welcome
    end
  end
end
