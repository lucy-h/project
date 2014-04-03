class ApplicationController < ActionController::Base
  before_filter :require_user
  before_filter :require_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  def current_user
    if @current_user.nil?
      @current_user = User.find(session[:user_id]) if session[:user_id]
    end
  end
  helper_method :current_user
  
  def require_user
    if current_user
      return true
    end
    redirect_to login_url
  end

  def admin_only
    if @current_user.role != "admin"
      redirect_to root_url
    end
  end

end
