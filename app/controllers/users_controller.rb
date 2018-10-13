class UsersController < ApplicationController
  before_action :new_user, only: [:show, :edit, :update, :destroy]

#user category votes
  def index
  end

  def show; end #method same as private find_user method (before_action)

  def edit; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'New User Created!'
      redirect_to root_path
    else
      flash.now[:error] = 'Sorry, an error has ocurred.'
      @user.errors.messages.each do |field, messages|
        flash.now[field] = messages
    end
      render :new
    end
  end

  def destroy

  end

  private

  def new_user
    @user = User.find_by(id: params[:id].to_i)

    if @user.nil?
      render :not_found
    end
  end

  def user_params
    return params.require(:user).permit(:handle)
  end
end
