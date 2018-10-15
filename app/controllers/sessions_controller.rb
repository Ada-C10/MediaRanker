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

      user = User.create(name: name)
      session[:user_id] = user.id

      redirect_to user_path(user)
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

  private

end
