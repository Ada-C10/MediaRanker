class UsersController < ApplicationController
  before_action :get_user, only: [:show]

  def index
    @users = User.all
  end

  def show; end

  private

  def get_user
    @user = User.find(params[:id])

    if @user.nil?
      flash.now[:warning] = "Cannot find the user"
    end
  end

end
