class UsersController < ApplicationController
  def new
  end

  def create
    user = User.find_by(params[:id])

    if user
      session[:user_id] = user.id
    else
      user = User.create(name: params[:id])
      session[:user_id] = user.id
    end
  end
end
