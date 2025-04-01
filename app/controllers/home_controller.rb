class HomeController < ApplicationController
  before_action :check_existing_survey, except: [ :choix_produit, :select_product ]
  before_action :authenticate_user!

  def index
  end

  def welcome
  end

  def choix_produit
    @products = current_user.startups.pluck("name")
  end

  def select_product
    name = params["product_name"]

    session[:startup_id] = current_user.active_startups.find_by(name: name)
  end

  private

  def check_existing_survey
    if session[:startup_id].blank?
      redirect_to action: :choix_produit
    end
  end
end
