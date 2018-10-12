class SessionsController < ApplicationController
  def login
    user = User.find_by(username: params[:user][:username])

    if user.nil?
      @user = User.new(username: params[:user][:username])
      if @user.save
        session[:user_id] = user.id
        flash[:success] = "Pleased to meet you #{@user.username}! Start voting!"
        redirect_to root_path
      else
        flash.now[:warning] = "No username entered. Try again."
        render :new
      end
    else
      session[:user_id] = user.id
      flash[:success] = "Welcome back #{user.username}!"
      redirect_to root_path
    end

  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out.'
    redirect_back(fallback_location: root_path)
  end

end
