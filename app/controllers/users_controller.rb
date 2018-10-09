class UsersController < ApplicationController
  def index
    @users = User.all.order(:id)
  end

  def show
    id = params[:id]
    @user = User.find_by(id: id)

    if id == nil
      render :not_found, status: :not_found
    end

  end

  def edit
    id = params[:id]
    @user = User.find_by(id: id)
  end

  def new
    @user = User.new
  end


  def update
    id = params[:id]
    @user = User.find_by(id: id)
    @user.update(user_params)

    if @user.save
      redirect_to users_path # go to the index so we can see the book in the list
    else
      render :new
    end
  end

  def create
    @user = User.new(user_params)
    # @task = Task.new(name: params[:task][:name], description: params[:task][:description], due: params[:task][:due]) #instantiate a new book
    if @user.save # save returns true if the database insert succeeds
      redirect_to root_path # go to the index so we can see the book in the list
    else # save failed :(
      render :new # show the new book form view again
    end
  end

  def destroy
    id = params[:id]
    @user = User.find_by(id: id)
    if @user.destroy
      redirect_to root_path
    end
  end

end

  def user_params
      return params.require(:user).permit(:username)
    end
