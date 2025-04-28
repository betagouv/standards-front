# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    email = request.env["omniauth.auth"]
             .info
             .email

    if user = EspaceMembre::User.find_by(primary_email: email)
      session[:user] = user.uuid

      redirect_to startups_index_path, notice: "Connexion réussie pour #{user.fullname}."
    else
      redirect_to root_path, alert: "Something went wrong"
    end
  end
end
