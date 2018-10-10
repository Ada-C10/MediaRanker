class SessionsControllerController < ApplicationController
  def new
  end

  def create
  end

  def login
    user = User.find_by(username: params[:username])

    if user
      session[:username] = user.id
      flash[:success] = "#{ user.user_id } is successfully logged in!"
      redirect_to root_path
    end 
  end

end
