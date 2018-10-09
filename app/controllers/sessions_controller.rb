class SessionsController < ApplicationController
  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
      # create a new user
      user= User.create(name: params[:user][:name])
    else
      # login existing user
    end
    # store user id for session
    session[:user_id] = user.id
    session[:user_name] = user.name
    flash[:success] = "Welcome #{user.name}!"
    redirect_to root_path

  end

  def new
    @user = User.new
  end

  def destroy
    # wipe the user id for the session
    session[:user_id] = nil
    # flash msg to user confirming logout
    flash[:success] = 'Goodbye'
    # go back to prev page or use fallback location to root
    redirect_back fallback_location: root_path
  end
end
