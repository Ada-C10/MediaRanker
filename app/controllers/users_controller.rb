class UsersController < ApplicationController
  def login
    user = User.find_by(name: params[:user][:name])
    if user.nil?
      user = User.new(name: params[:user][:name], join_date: Date.today)
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Successfully created new user #{user.name} with ID #{user.id}."
        redirect_to root_path
      else
        flash.now[:warning] = "A problem occurred: User not created."
        user.errors.messages.each do |field, messages|
          flash.now[field] = messages
        end
        render :new
      end
    else
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{user.name}."
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out."
    redirect_back fallback_location: root_path
  end

  def index
    @users = User.all
  end

  def show
    id = params[:id]
    @user = User.find_by(id: id)
  end
end
