class SessionsController < ApplicationController
  def new
  end

  def create
    name = params[:username]
    user = User.find_by(username: name)

    if user
      flash[:success] = "Successfully logged in as #{user.username}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      new_user = User.new(username: name)
      new_user.save
      flash[:success] = "Successfully created a new user #{new_user.username} with id #{new_user.id}"
      session[:user_id] = new_user.id
      redirect_to root_path
    end
  end
end
