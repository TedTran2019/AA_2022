class ApplicationController < ActionController::Base
  helper_method :login!, :logout!, :current_user, :logged_in?, :require_logged_out

  def login!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    @current_user = user
  end 
  
  def logout!
    return false unless current_user
    
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
    true
  end

  def current_user
    return nil unless session[:session_token]

    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end
end

def require_logged_out
  redirect_to subs_url if logged_in?
end

def require_logged_in
  redirect_to new_session_url unless logged_in?
end