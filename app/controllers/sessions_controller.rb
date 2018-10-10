class SessionsController < ApplicationController
  def login
    # Need to find user
    user = User.find_by(name: params[:user][:name])
    # Check if this person exists, if not create them
    if user.nil?
      # Create a new author if one doesn't exist
      user = User.create(name: params[:user][:name])
    else
      # Log in the existing user
      # No code needed
    end
    # Person who is logged in gets saved
    session[:user_id] = user.id
    # Flash notice
    flash[:success] = "Welcome #{user.name}"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def destroy
    # Set user id to nil
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    # Go back to where you came from or if you came straight here
    # Go back to the home page
    redirect_back fallback_location: root_path
  end
end
