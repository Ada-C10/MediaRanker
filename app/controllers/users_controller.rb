class UsersController < ApplicationController

    def index
      # @user = User.all.order(:due_date)
        @users = User.all
    end

    def show
      if @user = User.find_by(id: params[:id].to_i)
      else
        return head :not_found
      end
    end

    # def new
    #   @user = User.new
    # end
    #
    # def create
    #   @user = User.new(user_params)
    #
    #   result = @user.save
    #
    #   if result
    #     redirect_to users_path
    #   else
    #     render :new
    #   end
    # end
    #
    # def edit
    #   @user = User.find_by(id: params[:id])
    #   if !@user
    #     return head :not_found
    #   end
    # end
    #
    # def update
    #   @user = User.find(params[:id])
    #
    #   result = @user.update(user_params)
    #
    #   if result
    #     redirect_to user_path(@user)
    #   else
    #     render :edit
    #   end
    # end
    #
    # def destroy
    #
    #   @user = User.find_by(id: params[:id])
    #
    #   if @user
    #     @user.destroy
    #     redirect_to users_path
    #   else
    #     return head :not_found
    #   end
    # end


    private

    def user_params
      return params.require(:user).permit(
        :username,
      )
    end
  end

  end

end
