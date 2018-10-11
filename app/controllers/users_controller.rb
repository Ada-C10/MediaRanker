class UsersController < ApplicationController
  def index
    @users = User.all.order(join_date: :asc)
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash.now[:danger] = "Cannot find the user #{params[:id]}"
      render :notfound, status: :not_found
    end
  end
end
