class UsersController < ApplicationController
  def index
    # Current user will be that model, else it will be nil (not logged in)
    # Use a filter here - Run this method every time
    # Always find the user or always find the top 10
    current_user = User.find_by(id: session[:user_id])
  end

  def show
    # Do I need current user here?

  end

  def new
    @user = User.new 
  end

  def create
  end
end
