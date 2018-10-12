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

    # QUESTION: why does this work without new or create methods?
    # why is it ok to just create the new user from the sessions controller?
    # def new
    #   @user = User.new()
    # end
    #
    # def create
    #   @user = User.new(user_params)
    #   @user.save
    # end

    private

    def user_params
      return params.require(:user).permit(
        :username,
      )
    end


end
