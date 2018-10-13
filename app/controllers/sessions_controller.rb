class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def login
    user = User.where("name ILIKE?", session_params[:name]).first
      if user.nil?
        # Create a new user
        user = User.create(name: session_params[:name])
        salutation = "Welcome"
        session[:salutation] = "Hi"
      else
        # Log in the existing user
        salutation = "Welcome back"
        session[:salutation] = "Welcome back"
      end

      session[:user_id] = user.id
      if session[:user_id]
        flash[:success] = "Succesfully logged in. #{salutation} #{user.name}!"
      else
        flash[:warning] = "User not created."
      end

      redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_back fallback_location: root_path # required argument
  end

  private

  def session_params
    return params.require(:user).permit(:name)
  end

end
