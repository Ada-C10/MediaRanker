class SessionsController < ApplicationController
  def new
  end

  def create
    name = params[:user_name]
    user = User.find_by(user_name: name)
    
    if user
      flash[:existing_user] = "Welcome back #{name}!"
    else
      # if user != false
      flash[:new_user] = "Successfully logged in as new user \"#{name}\""
      user = User.create(:user_name => name)

      # end
      # flash.now[:error] = "Could not log in"
    end
    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
