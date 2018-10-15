class SessionsController < ApplicationController
  def new
  end

  def create
    name = params[:user_name]
    user = User.find_by(name: name)

    if user
      session[:user_id] = user.id
      flash[:success] = "#{user.name} is successfully logged in"
      redirect_to root_path

    else
      user = User.create(name: name)
      redirect_to root_path
      flash[:success] = "#{user.name} is successfully logged in"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
