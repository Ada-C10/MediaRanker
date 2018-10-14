class SessionsController < ApplicationController

  def new
  end

  def create
    name = params[:name]

    @user = User.find_by(name: name)

    if @user
      flash[:success] = "Successfully logged in as existing user #{name}"
    else
      @user = User.new(name: name)
      @user.save
      flash[:success] = "Successfully created new user #{name} with ID #{@user.id}"
    end

    session[:user_id] = @user.id
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
