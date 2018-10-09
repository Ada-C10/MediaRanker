class SessionsController < ApplicationController
  def new
    # QUESTION: PUT OBJ HERE? NO B/C SESSIONS NOT AN OBJ?
  end

def create
  # QUESTION: or def login???
	username = params[:username]
	user = User.find_by(username: username)

	if user
		flash[:success] = "Successfuly logged in as existing user #{name}"
	else
    user = User.new(username: username) # if user not found, create a new one
    # QUESTION: create if/else if not saved successfully??
		flash.now[:success] = "Successfully created new user #{username} with ID #{user.id}"
	end
  
  session[:user_id] = user.id
  redirect_to root_path
end

def logout
	session[:user_id] = nil
	flash[:success] = "Successfully logged out"
	redirect_to root_path
end
end
