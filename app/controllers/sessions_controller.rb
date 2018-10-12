class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:user_name]
    user = User.find_by(username: username)

    if user
      flash[:success] = "Successfully logged in as #{username}"
      session[:user_id] = user.id
      redirect_to user_path(user)

    else
      flash.now[:error] = "No such username \"#{username}\""
      render :new
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Succesfully logged out!"
    redirect_to root_path
  end

end
