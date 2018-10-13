class SessionsController < ApplicationController
  def new
    @session = Session.new
  end
  
  def login
    user = User.find_by(name: params[:user_name])

    if user
      session[:user_id] = user.id
      flash[:success] = "#{ user.user_name } is successfully logged in"
      redirect_to root_path
    end
  end
end
