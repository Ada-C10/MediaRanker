class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(user_name: params[:user_name])

    if @user.nil?
      @user = User.new(user_name: params[:user_name])
      if @user.save
        flash[:success] = "Successfully logged in as new user #{@user.user_name}"
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash.now[:error] = "Could not log in"
        render :new
      end
    else
      session[:user_id] = @user.id
      flash[:success] = "Welcome back #{@user.user_name}!"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
