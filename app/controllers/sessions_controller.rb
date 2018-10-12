class SessionsController < ApplicationController
  def login

    #where does the user_name symbol come from?
    # in ada books example it was name: params[:author][:name]
    user = User.find_by(user_name: params[:user][:user_name])
    if user.nil?
      user = User.create(user_name: params[:user][:user_name])
      flash["success"] = "Successfully created new user #{user.user_name} with ID #{user.id}"
    else
      flash["success"] = "Successfully logged in as existing user #{user.user_name}"
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def destroy
    #where does user_id come from?
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out'
    redirect_back fallback_location: root_path
  end
end
