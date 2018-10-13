class SessionsController < ApplicationController

  def  new
  end

  def create
    user = User.find_by(username: params[:username])
    if user
      #login user / assign session user_id as current user
      session[:user_id] = user.id
      flash[:success] = "Existing user '#{user.username}' successfully logged in."
      #redirect to user's show page
      redirect_to user_path(user)
    else
      #direct them to sign in
      # redirect_to signup_path
      user = User.new(username: params[:username])
      if user.save
        flash[:success] = "User '#{user.username}' signed up and logged in."
        redirect_to user_path(user)
      else
        flash[:failure] = "Username invalid or does not exist. Please sign up here."
        redirect_to signup_path
      end
    end
  end

  def destroy
  end

end
