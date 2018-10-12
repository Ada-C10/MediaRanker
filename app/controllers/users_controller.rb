class UsersController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name])

    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      user = User.create(name: params[:name])

      session[:user_id] = user.id
      redirect_to root_path
    end
  end
end
