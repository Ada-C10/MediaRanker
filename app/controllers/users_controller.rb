class UsersController < ApplicationController
  def index
    @users = User.all.order(join_date: :asc)
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      render :notfound, status: :not_found
    end
  end
end
