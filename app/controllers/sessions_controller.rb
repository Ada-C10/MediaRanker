class SessionsController < ApplicationController
  def new
    @user = User.new()
  end

  def login
    user = User.find_by(name: params[:user][:name])
    if !user
      user = User.create(name: params[:user][:name])
      flash[:success] = "Successfully created new user #{user.name} with ID #{user.id}"
    else
      flash[:success] = "Successfully logged in as existing user #{user.name}"
    end
    session[:user_id] = user.id
    redirect_to session[:return_to]
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_back fallback_location: root_path
  end
end
