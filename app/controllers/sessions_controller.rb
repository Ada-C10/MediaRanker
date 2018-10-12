class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:username]
    user = User.find_by(username: username)

    if user
      flash[:success] = "Successfully logged in as #{username}"
      session[:user_id] = user.id
      redirect_to root_path

    else
      flash[:error] = "No such username exists"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Succesfully logged out!"
    redirect_to root_path
  end

end
