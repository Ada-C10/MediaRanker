class SessionsController < ApplicationController
  def login
    user = User.find_by(username: params[:user][:username])

    if user.nil?
      user = User.new(username: params[:user][:username])
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Successfully created account and logged in as #{user.username}!"
        redirect_to root_path
      else
        flash[:warning] = "User was not successfully added"
        redirect_to login_path
     end
   else
     session[:user_id] = user.id
     flash[:success] = "Successfully logged in as existing user #{user.username}!"
     redirect_to root_path
   end
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out'
    redirect_back fallback_location: root_path
  end
end
