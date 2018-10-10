class SessionsController < ApplicationController
  def new
    @user = User.new()
  end

  def create
    username = params[:username]
    @user = User.find_by(username: username) #QUESTION: param obj or attribute???

    if @user
      flash[:success] = "Successfuly logged in as existing user #{username}"
    else
      @user = User.new(username: username) # if user not found, create a new one

      @user.save
      #?????
      # QUESTION: create if/else if not saved successfully??
      flash[:success] = "Successfully created new user #{username} with ID #{@user.id}"
    end

    session[:user_id] = @user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
