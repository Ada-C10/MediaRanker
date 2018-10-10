class SessionsController < ApplicationController
  def login
    @user = User.new()
  end

  def new
    user = User.find_by(name: params[:user][:name])
    if !user
      user = User.create(name: params[:user][:name])
    end
    session[:user_id] = user.id
    flash[:success] = "Successfully logged in as existing user #{user.name}"
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
  end
end
