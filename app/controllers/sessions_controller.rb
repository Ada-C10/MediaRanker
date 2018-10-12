class SessionsController < ApplicationController
  def login
    @user = User.find_by(name: params[:user][:name])

    if @user.nil?
      @user = User.create(name: params[:user][:name], join_date: Date.current)
    else
      flash[:success] = "Successfully logged in as existing user #{@user.name}"
    end

    #FIX THIS - it keeps creating new user
    if @user.valid?
      flash[:success] = "Successfully created new user #{@user.name} with ID #{@user.id}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_back(fallback_location: root_path)
  end
end
