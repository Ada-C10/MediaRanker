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

  private

  #strong params
  def user_params
    return params.require(:work).permit(
      :username
    )
  end
end
