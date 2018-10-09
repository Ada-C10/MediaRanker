class UsersController < ApplicationController
  def index
    @current_user = User.find_by(id: session[:user_id])
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
  end

  def create
    
  end

  def destroy
  end
end
