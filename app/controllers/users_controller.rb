class UsersController < ApplicationController
  def index
    @users = User.all
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new

    if @user.save
      flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
      redirect_to works_path
    else
      flash.now[:error] = "A problem occurred: Could not create #{@user.username}"
      render :new, status: :bad_request
    end
  end


  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
    end
  end

end
