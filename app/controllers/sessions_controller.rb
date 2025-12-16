# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    email = request.env["omniauth.auth"]
             .info
             .email

    session[:user] = EspaceMembre::User.identify_email!(email).uuid

    redirect_to startups_path, notice: "Connexion réussie pour #{email}"
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = t(".user_not_found", deep_interpolation: true, email: email)

    if proconnect_setup?
      redirect_to "/auth/proconnect/logout"
    else
      redirect_to login_path
    end
  end

  def destroy
    session.delete :user

    if proconnect_setup?
      redirect_to "/auth/proconnect/logout"
    else
      redirect_to root_path, notice: "Déconnexion terminée."
    end
  end

  def proconnect_logged_out
    clear_proconnect_setup!
  end

  private

  def proconnect_session_bits
    session.to_hash.select { |k, _| k.include?("omniauth.pc") }
  end

  def clear_proconnect_setup!
    proconnect_session_bits.each { |k, _| session.delete(k) }
  end

  def proconnect_setup?
    proconnect_session_bits.any?
  end
end
