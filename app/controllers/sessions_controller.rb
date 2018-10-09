class SessionsController < ApplicationController

  def login
    user = User.find_by(name: user_params[:name])

      if user.nil?
        # Create a new user
        user = User.create(name: user_params[:name])
      else
        # Log in the existing user
      end

      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}"
      redirect_to root_path
  end

  def new
    @user = User.new
  end

  def destroy
  end
end
