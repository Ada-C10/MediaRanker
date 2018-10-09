class SessionsController < ApplicationController
  def login
    @user = User.find_by(name: params[:user][:name])
    if @user.nil?
      #create a new user
      user = User.create(name: params[:user][:name])
    else
      #log in existing author
  end

  session[:user_id] = [user.id]
  flash[:success] = "Welcome #{user.name}!"
  redirect_to root_path
end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Sucessfully logged out'
    redirect_back fallback_location: root_path
  end

  def new
    @user = User.new
  end

  private
  def user_params
      return params.require(:user).permit(:name)

end

end
