class SessionsController < ApplicationController

  def new
  end

  def create
    name = params[:username]
    user = User.find_by(username: name)

    if user

      redirect_to root_path
      flash[:success] = "Successfully logged in as #{name}"
      session[:user_id] = user.id

    else
      @user = User.new(username: name)
      if @user.save
        flash.now[:success] = "Successfully created new user \"#{name}\" with ID #{User.find_by(username: name).id}"
        redirect_to root_path
      else
        render :new
      end
    end
  end

  def logout
  end

end
