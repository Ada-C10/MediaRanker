class SessionsController < ApplicationController
  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
      user = User.create(name: params[:user][:name], join_date: Date.current)
      flash[:success] = "Successfully created new user #{user.name} with ID #{user.id}"
    else
      flash[:success] = "Successfully logged in as existing user #{user.name}"
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_back(fallback_location: root_path)
  end

  private
  def sessions_params
    return params.require(:user).permit(:name)
  end
end
