class SessionsController < ApplicationController

  def new
  end

  def create
    # create user, assign to vari, see if user already exists, assign to user vari
    name = params[:user_name]
    user = User.find_by(user_name: name)

    if user #truthy - if user already exists
      flash[:success] = "Welcome back, successfully logged in as #{name}"
      session[:user_id] = user.id

      redirect_to root_path

    else # create a new user if doesn't exist
      user = User.new(user_name: name)
      is_successful_save = user.save

      if is_successful_save
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as #{name}"
      else
        render :new, status: :bad_request
      end
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end


end
