class SessionsController < ApplicationController
  def new
    @user = User.new()
  end

  def login
    user = User.find_by(name: params[:user][:name])
    if !user
      user = User.create(name: params[:user][:name])
    end
    session[:user_id] = user.id
    flash[:success] = "Successfully logged in as existing user #{user.name}"

    redirect_to session[:return_to]
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_back fallback_location: root_path
  end
end
