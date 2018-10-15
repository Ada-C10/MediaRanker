class SessionsController < ApplicationController
#sign up then login?

  def login
    # @users = User.all
    @user = User.find_by(handle: params[:user][:handle])

    if @user.nil?
      # redirect_to root_path
      @user = User.create(handle: params[:user][:handle])
      flash.now[:error] = 'Sorry, we cannot find that username.'
      # render :login
      if !@user.valid?
        flash[:danger] = "Didn't work"
        redirect_to root_path
      end
    end

    if @user.valid?
      session[:user_id] = @user.id
      flash[:success] = "Hello, #{@user.handle} you are now logged in."
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end


  def destroy
    session[:user_id] = nil
    flash[:success] = 'You are now logged out. Good-bye.'
    redirect_back fallback_location: root_path
  end
end
