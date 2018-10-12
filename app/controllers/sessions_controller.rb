class SessionsController < ApplicationController
  def new
  end

  def create
    name = params[:name]
    user = User.find_by(name: name)

    if user
      flash[:success] = "Successfully logged in as #{name}"
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:error] = "No such user \"#{name}\""
      render :new
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
