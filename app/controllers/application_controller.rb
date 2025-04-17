class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user

  def current_user
    @current_user ||= EspaceMembre::User.find_by(uuid: session[:user])
  end

  def authenticate_user!
    redirect_to :login if current_user.nil?
  end
end
