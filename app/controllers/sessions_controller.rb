class SessionsController < ApplicationController

  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
      #create new user
      user = User.new(name: params[:user][:name])
      if user.save
        #log in the existing user
        session[:user_id] = user.id #where does :user_id come from?
        flash[:success] = "#{user.name} Successfully logged in!"
        # raise
        redirect_to root_path
      else
        flash[:warning] = "Not able to log in "
        redirect_to root_path
      end

    else
      session[:user_id] = user.id #where does :user_id come from?
      flash[:success] = "#{user.name} Successfully logged in!"
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
