class UsersController < ApplicationController
  def index
    @users = User.all(:id)
  end

  def show
    id = params[:id].to_i
    @users = user.find(params[:id].to_i)
    if id.nil?
      render :notfound
    end
  end
end
