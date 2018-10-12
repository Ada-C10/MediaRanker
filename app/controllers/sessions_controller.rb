class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:username]
    user = User.find_by(username: username)

    if user
      flash[:success] = "#{user.username} is successfully logged in."
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:error] = "User not found"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Succesfully logged out!"
    redirect_to root_path
  end

end
