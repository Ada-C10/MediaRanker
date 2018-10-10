class SessionsController < ApplicationController
  def login
    user = User.find_by(username: params[:user][:username])

    if user.nil? # Create a new user
      user = User.create(username: params[:user][:username])
    # Else: login existing user, no need to do anything
    end

    session[:user_id] = user.id
    flash[:success] = "#{user.username} successfully logged in"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_back(fallback_location: root_path)
  end
end
