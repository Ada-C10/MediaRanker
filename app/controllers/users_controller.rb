class UsersController < ApplicationController
  def index
    # Current user will be that model, else it will be nil (not logged in)
    # Use a filter here - Run this method every time
    # Always find the user or always find the top 10
    @current_user = User.find_by(id: session[:user_id])
    @users = User.all.order(:name)
  end

  def show
    @current_user = User.find_by(id: session[:user_id])
    # Figure out how to show user votes... 
    # @votes = @current_user.votes.all

    if @user.nil?
      render :notfound, status: :not_found
    end

  end

  def new
    @user = User.new
  end

  def create
  end
end
