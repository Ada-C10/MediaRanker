class UsersController < ApplicationController

    def index
        @users = User.all.order(:created_at)
    end

    def show
      @user = User.find_by(id: params[:id])
      if @user
        return @user
      else
        return head :not_found #QUESTION: status?
      end
    end

    private

    def user_params
      return params.require(:user).permit(
        :username,
      )
    end


end
