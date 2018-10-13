class SessionsController < ApplicationController

  def new
  end

  def create
    name = params[:name]
    user = User.find_by(name: name)

    if user
      flash[:success] = "Successfully logged in as #{name}"
      session[:user_id] = user.id
      redirect_to user_path(user)

    else
      name = params[:name]
      user = User.new(name: name)
      is_successful_save = user.save

      if is_successful_save
        flash[:success] = "Successfully logged in as #{name}"
        redirect_to user_path(user)
      else
        flash.now[:error] = "Invalid name"
        render :new, status: :bad_request
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

end
