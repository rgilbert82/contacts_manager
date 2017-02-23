class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def require_user
    if !logged_in?
      flash[:notice] = 'You must be logged in to do that'
      redirect_to login_path
    end
  end

  def current_user
    if session[:user_id] && User.exists?(session[:user_id])
      @current_user ||= User.find(session[:user_id])
    end
  end

  def set_user
    @user = current_user
  end

  def logged_in?
    !!current_user
  end

  def user_is_logged_in
    flash[:notice] = "You are logged in"
    redirect_to root_path
  end
end
