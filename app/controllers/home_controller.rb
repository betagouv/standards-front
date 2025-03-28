class HomeController < ApplicationController
  before_action :check_existing_survey, except: :welcome

  before_action :authenticate_user!

  def index
  end

  def welcome
    @products = current_user.startups.pluck("name")
  end

  private

  def check_existing_survey
    if session[:survey_id].blank?
      redirect_to action: :welcome
    end
  end
end
