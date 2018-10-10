class SessionsController < ApplicationController
  def login
    @user = User.find_by(name: params[:user][:name])
    if @user.nil?
      @user = User.create(name: params[:user][:name])
  end

  session[:user_id] = [@user.id]
  session[:name] = [@user.name]
  @current_user = User.find_by(id: session[:user_id]  )
  flash[:success] = "Welcome #{@user.name}!"
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

end
