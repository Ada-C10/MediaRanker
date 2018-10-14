class SessionsController < ApplicationController

  def new
  end

  def create
    name = params[:username]
    user = User.find_by(username: name)

    if user
      flash[:success] = "Successfully logged in as #{name}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      @user = User.new(username: name)
      if @user.save
        flash[:success] = "Successfully logged in as new user \"#{name}\" "
        redirect_to root_path
      else
        render :new
      end
    end
  end

  def logout
  end

end
