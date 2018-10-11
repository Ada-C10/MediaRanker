class SessionsController < ApplicationController
  def login
    user = User.find_by(username: params[:user][:username])
    if user.nil?
    # Create a new user
      user = User.create(username: params[:user][:username], Date.today => params[:user][:join_date])
      user.join_date = Date.today
    end

    session[:user_id] = user.id
    flash[:success] = "#{user.name} Successfully logged in!"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def destroy #logout method
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out'
    redirect_back fallback_location: root_path
  end
end
