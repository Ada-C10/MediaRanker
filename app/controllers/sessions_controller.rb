class SessionsController < ApplicationController
  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
      # create a new user
      user = User.create(name: params[:user][:name])
      flash[:success] = "Welcome #{user.name}, you have been added as a new user. Your ID is #{user.id}."
    else
      # login existing user
      flash[:primary] = "Welcome back #{user.name}!"
    end
    # store user id for session
    session[:user_id] = user.id
    session[:user_name] = user.name

    redirect_to root_path

  end

  def new
    @user = User.new
  end

  def destroy
    # wipe the user id for the session
    session[:user_id] = nil
    # flash msg to user confirming logout
    flash[:secondary] = "Goodbye #{session[:user_name]}, come back soon!"
    # go back to prev page or use fallback location to root
    redirect_to root_path
  end
end
