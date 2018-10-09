class UsersController < ApplicationController

  private

  def user_params
    return params.require(:user).permit(:name)
  end

end
