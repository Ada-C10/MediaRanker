class SessionsController < ApplicationController
  def login
    user = User.find_by(username: params[:user][:username])
    flash[:success] = "#{params[:user][:username]} Successfully logged in!"

    if user.nil?
    # If user does not exist, create a new user
      user = User.create(username: params[:user][:username])
      flash[:success] = "#{user.username} Successfully created"

    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def new #sends you to login form
    @user = User.new
  end

  def destroy #logout method
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end
end
