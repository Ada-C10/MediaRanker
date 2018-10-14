class SessionsController < ApplicationController
  def login
    user = User.find_by(user_name: params[:user][:user_name])

    if user
      session[:user_id] = user.id
      flash[:success] = "#{ user.user_name } is successfully logged in"
      redirect_to root_path
    else
      user = User.create(user_name: params[:user][:user_name])
        if user.valid? == false
          flash[:warning] = "Unsuccessful Login"
            user.errors.messages.each do |field, messages|
              flash[field] = messages
            end
            # when I tried render :new it would display messages
            # but when I try to sign in correctly after - I would get an error message
            redirect_to login_path
        else
          flash[:success] = "Successfully log in as new user #{user.user_name}"

          session[:user_id] = user.id
          redirect_to root_path
        end
    end
  end

  def new
    @user = User.new
  end

  def destroy
    #where does user_id come from?
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out'
    redirect_back fallback_location: root_path
  end
end
