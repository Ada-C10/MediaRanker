class UsersController < ApplicationController
  def index
  end

  def show
  end
end

def create
  @user = User.new(user_params)
  if @user.save # save returns true if the database insert succeeds
    flash[:success] = 'User Created!'

    redirect_to root_path # go to the index so we can see the book in the list
  else # save failed :(
    flash.now[:danger] = 'User not created!'
    @user.errors.messages.each do |field, messages|
      flash.now[field] = messages
    end

    render :new # show the new book form view again
  end



private
def user_params
  return params.require(:user).permit(:name)
end

end
