class SessionsController < ApplicationController
  def login

    #where does the user_name symbol come from?
    # in ada books example it was name: params[:author][:name]
    user = User.find_by(user_name: params[:user][:user_name])
    if user.nil?
      user = User.create(user_name: params[:user][:user_name])
      if user.valid? == false
        flash[:warning] = "Unsuccessful Login"
        # why don't my error messages pop up for validations?
        user.errors.messages.each do |field, messages|
          flash.now[field] = messages
        end
        redirect_to login_path
      end
    else
      flash[:success] = "Successfully logged in as existing user #{user.user_name}"
      session[:user_id] = user.id
      redirect_to root_path
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
