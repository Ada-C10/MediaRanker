class SessionsController < ApplicationController

  def new
  end

  def create
    name = params[:username]
    user = User.find_by(username: name)

    if user
      flash[:success] = "Successfully logged in as #{name}"
      session[:user_id] = user.id
      session[:username] = name
      redirect_to home_path
    elsif name.empty?
      flash.now[:error] = "Missing username. Try again."
      render :new
    else
      @user = User.new(username: name)
      if @user.save
        flash[:success] = "Successfully logged in as #{@user.username}"
        session[:user_id] = @user.id
        session[:username] = name
        redirect_to home_path
      else
        render :new
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
