class SessionsController < ApplicationController
  skip_before_filter :require_user 
  # Note that this is omitted: :only => [:new, :create, :destroy]
  # In the case that we need to logout because the active session's
  # user was deleted, then require_user will fail (since require_user
  # requires that the current user_id is valid, which it isn't because
  # it was just deleted.)

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user
      session[:user_id] = user.id
      redirect_to courses_path
    else
	  redirect_to login_path , notice: "Account not found."
    end  
  end

  def destroy
  	session[:user_id] = nil
    redirect_to root_url
  end

end
