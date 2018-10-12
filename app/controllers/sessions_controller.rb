class SessionsController < ApplicationController
  def login
    # find user in database to see if the user is an existing user or we need to create a new one
    user = User.find_by(username: params[:user][:name])

    if user.nil?
      # Create a new author
      user = User.create(username: params[:user][:name])
      flash.now[:success] = "Successfully created a new user #{user.username} with ID #{user.id}!"
    end

    session[:user_id] = user.id
    flash[:success] = "Successfully logged in as an existing user #{user.username}"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out'
    redirect_back fallback_location: root_path
  end
end
