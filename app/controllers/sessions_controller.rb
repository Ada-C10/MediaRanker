class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def login
    user = User.find_by(name: session_params[:name])

      if user.nil?
        # Create a new user
        user = User.create(name: session_params[:name])
      else
        # Log in the existing user
      end

      session[:user_id] = user.id
      if session[:user_id]
        flash[:success] = "Succesfully logged in. Welcome #{user.name}!"
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
