class SessionsController < ApplicationController
  def login
     # find user in database to see if the user is an existing user or we need to create a new one
     user = User.find_by(username: params[:user][:name])
     if user.nil?
       user = User.create(username: params[:user][:name])
       # how come it saves them? without a user.save
       flash[:success] = "Successfully created a new user #{user.username} with ID #{user.id}!"
     else
       flash[:success] = "Successfully logged in as an existing user #{user.username}"
     end
       session[:user_id] = user.id
       redirect_to root_path
   end
  def new
    @user = User.new
  end
  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out'
    redirect_to root_path
end
