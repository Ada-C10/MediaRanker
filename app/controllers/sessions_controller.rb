class SessionsController < ApplicationController

  def new
  end

  def login
    name = params[:username]
    user = User.find_by(username: name)

    if user
      session[:user_id] = user.id
      flash[:sucess] = "Successfully logged in as existing user #{user.username}"
      redirect_to root_path
    else
      new_user = User.new(name: name)
      session[:user_id] = new_user.id
      if new_user.save
        flash[:sucess] = "Successfully created new user #{new_user.username} with ID #{new_user.id}"
        redirect_to root_path

        # if user.save
        #   flash[:sucess] = "Successfully created new user #{user.username} with ID #{user.id}"
        #   redirect_to root_path
        end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
  end

end
