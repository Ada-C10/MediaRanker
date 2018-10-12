class SessionsController < ApplicationController

  def create
<<<<<<< HEAD
    username = params[:username]
    user = User.find_by(username: username)

    if user
      flash[:success] = "#{user.username} is successfully logged in."
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:error] = "User not found"
      redirect_to root_path
=======
    username = params[:user_name]
    user = User.find_by(username: username)

    if user
      flash[:success] = "Successfully logged in as #{username}"
      session[:user_id] = user.id
      redirect_to user_path(user)

    else
      flash.now[:error] = "No such username \"#{username}\""
      render :new
>>>>>>> controllers
    end
  end

  def logout
    session[:user_id] = nil
<<<<<<< HEAD
    flash[:success] = "Succesfully logged out!"
=======
    flash[:success] = "Successfully logged out"
>>>>>>> controllers
    redirect_to root_path
  end

end
