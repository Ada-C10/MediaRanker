class SessionsController < ApplicationController

  def  new
  end

  def create
    user = User.find_by(username: params[:username])
    if user
      #login user / assign session user_id as current user
      session[:user_id] = user.id
      flash[:success] = "Existing user '#{user.username}' logged in!"
      #redirect to user's show page
      redirect_to user_path(user)
    else
      #direct them to sign in
      user = User.new(username: params[:username])
      if user.save
        #login user / assign session user_id as current user
        session[:user_id] = user.id
        flash[:success] = "User '#{user.username}' signed up and logged in!"
        redirect_to root_path
      else
        # redirect_to signup_path
        flash[:failure] = "Username invalid or does not exist. Please sign up below."
        redirect_to signup_path
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end

end
