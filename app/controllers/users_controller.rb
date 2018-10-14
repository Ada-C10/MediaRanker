class UsersController < ApplicationController
  def index
  @users = User.all.order(:id)
  end

  def show
    id = params[:id].to_i
    @user = User.find_by(id: id)

    if @user.nil?
     render :notfound, status: :not_found
    end
  end

  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
       user = User.new(name: params[:user][:name])

       if user.save
         session[:user_id] = user.id
         flash[:success] = "#{user.name} Successfully logged in!"
         redirect_to root_path
       else
         flash[:warning] = "Could not log in, please provide a username more than 3 letters."

         redirect_back fallback_location: root_path
       end
    else
       session[:user_id] = user.id
       flash[:success] = "#{user.name} Successfully logged in!"
       redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out'
    redirect_back fallback_location: root_path
  end

end
