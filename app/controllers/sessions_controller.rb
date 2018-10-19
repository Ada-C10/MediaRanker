class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:user][:username])

    if user
      session[:user_id] = user.id
      flash[:success] = "#{ user.username }, you have successfully logged in."
      redirect_to works_path
    else
      user = User.new(username: params[:user][:username])
      if user.save
        session[:user_id] = user.id
        flash[:success] = "#{ user.username }, you have successfully logged in."
        redirect_to works_path
      else
        flash[:failure] = "Unsuccessful login! Please try again."
        render :new
      end
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "Logged out successfully."
    redirect_to works_path
  end

end
