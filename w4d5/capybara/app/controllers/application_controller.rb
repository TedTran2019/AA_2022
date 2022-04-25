class ApplicationController < ActionController::Base
  helper_method :current_user, :login!, :logout!, :logged_in?, :must_be_logged_in!

  def current_user
    return nil unless session[:session_token]

    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def logout!
    current_user.reset_session_token!
    @current_user = nil
    session[:session_token] = nil
  end

  def logged_in?
    current_user
  end

  def must_be_logged_in!
    redirect_to(new_session_url) unless current_user
  end
end
