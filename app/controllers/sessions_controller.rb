class SessionsController < ApplicationController
  def login
    user = User.find_by(name: params[:user][:username])
    if user.nil?
      user = User.create(name: params[:user][:username])
    end

    session[:user_id] = user.id
    flash[:success] = "Welcome #{user.name}!"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out.'
    redirect_back(fallback_location: root_path)
  end
  
end
