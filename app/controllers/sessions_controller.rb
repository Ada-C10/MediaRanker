class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:username]
    user = User.find_by(username: username)

    if user
      flash[:success] = "Successfully logged in as #{username}"
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:error] = "No such user \"#{username}\" "
      render :new
  end
end
