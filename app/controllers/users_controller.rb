class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  after_action :return_to, only: [:index, :show]


  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name)
    end

    def return_to
      session[:return_to] = request.fullpath
    end
end
