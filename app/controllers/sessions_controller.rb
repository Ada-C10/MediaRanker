class SessionsController < ApplicationController

  def new
  end

  def create
    name = params[:username]
    user = User.find_by(username: name)
      if user == nil
        user = User.new(username: name)
        user.save
      end

    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as #{name}"
      redirect_to root_path
    end

  end


  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
