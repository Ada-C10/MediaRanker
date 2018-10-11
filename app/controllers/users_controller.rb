class UsersController < ApplicationController
  def index
    @users = (User.all).sort_by do |user|
      user.id
    end
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      head :not_found
    end
  end

  def new
  end

  def create
  end

  private
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end

end
