# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user_info = request.env["omniauth.auth"]

    if user = EspaceMembre::User.find_by(primary_email: user_info["uid"])
      session[:user] = user.uuid

      redirect_to home_choix_produit_path, notice: "You're in!"
    else
      redirect_to root_path, alert: "Something went wrong"
    end
  end
end
