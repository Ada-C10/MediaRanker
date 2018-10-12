class UsersController < ApplicationController
  def index
    @users = User.order(:username)
  end

  def create
  end

  def new
  end

  def show
  end

  def destroy
  end
end
