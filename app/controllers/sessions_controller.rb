class SessionsController < ApplicationController

  def new
  end

  def create
    name = params[:user_name]
    user = User.find_by(name: name)

    if user
      flash[:success_exist] = "Successfully logged in as existing user #{name}"
    else
      user = User.create(name: name)
      flash[:success_new] = "Successfully logged in as new user #{name}"
    end
    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

end
