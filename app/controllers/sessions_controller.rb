class SessionsController < ApplicationController

  def new
  end

  def login
    name = params[:username]
    @user = User.find_by(username: name)

    if @user
      flash[:sucess] = "Successfully logged in as existing user #{@user.username}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user = User.new(username: name)

      if @user.save
        flash[:sucess] = "Successfully created new user #{@user.username} with ID #{@user.id}"
        session[:user_id] = @user.id
        redirect_to root_path
        end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

end
