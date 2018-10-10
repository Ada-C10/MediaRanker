class UsersController < ApplicationController
  def index
  @users = User.all.order(:id)
  end

  def show
    id = params[:id].to_i
    @user = User.find_by(id: id)

    if @user.nil?
     render :notfound, status: :not_found
    end
  end

end
