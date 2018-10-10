class SessionsController < ApplicationController

  def new
  end

  def create
    name = params[:username]
    user = User.find_by(username: name)

    if user
      flash[:success] = "Successfully logged in as #{name}"
      session[:user_id] = user.id
      redirect_to home_path
    else
      @user = User.new(username: name)
      if @user.save
        redirect_to home_path
      else
        render :new
      end
    end
  end
end
