class SessionsController < ApplicationController
  def new
  end

  # def create
  #   name = params[:user_name]
  #   user = User.find_by(user_name: name)
  #
  #   if user
  #     flash[:existing_user] = "Welcome back #{name}!"
  #   else
  #     user = User.create(:user_name => name)
  #     flash[:new_user] = "Successfully logged in as new user \"#{name}\""
  #   end
  #   session[:user_id] = user.id
  #   redirect_to root_path
  # end

  def create
    @user = User.find_by(user_name: params[:user_name])

    if @user.nil?
      @user = User.new(user_name: params[:user_name])
      if @user.save
        flash[:new_user] = "Successfully logged in as new user #{@user.user_name}"
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash[:notice] = "Could not log in"
        render :new
      end
    else
      session[:user_id] = @user.id
      flash[:existing_user] = "Welcome back #{@user.user_name}!"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
