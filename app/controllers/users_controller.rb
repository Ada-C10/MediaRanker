class UsersController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update]

  def index
    @users = User.all.order(:username)
  end

  def show; end

  def new
    @users = User.new
  end

  def create
    @users = User.new(user_params)

    if @users.save
      redirect_to users_path
    else
      render :new
    end
  end

  def update
   if @users.update(users_params)
     redirect_to users_path
   else
     render :edit
   end
 end

  def edit; end

  def destroy
    user = User.find_by(id: params[:id].to_i)
    @deleted_user = user.destroy

    if @deleted_user
      redirect_to users_path
    end
  end

  def upvote
    
  end

  private

  def user_params
    return params.require(:user).permit(:username, :upvote)
  end

end
