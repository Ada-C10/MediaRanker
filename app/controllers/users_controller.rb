class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user == nil
      flash.now[:failure]
      render 'layouts/invalid_page', status: :not_found
    end
  end

  def create
    filtered_user_params = user_params
    @user = User.new(filtered_user_params)

    if @user.save
      flash[:success] = "User #{@user.username} has successfully signed up!"
    else
      flash.now[:failure] = "Error: user could not be saved."
      render :new, status: 400
    end
  end

  private

  #strong params
  def user_params
    return params.require(:work).permit(
      :username
    )
  end
end
