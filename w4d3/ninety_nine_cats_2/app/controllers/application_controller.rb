class ApplicationController < ActionController::Base
  helper_method :current_user, :return_if_logged_in

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def return_if_logged_in
    redirect_to(cats_url) if current_user
  end

  def logged_in?
    redirect_to(cats_url) unless current_user
  end
end
