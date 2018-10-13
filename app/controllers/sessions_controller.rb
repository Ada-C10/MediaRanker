class SessionsController < ApplicationController

  def login
    user = User.find_by(username: params[:username])

    if user
      session[:user_id] = user.id
      flash[:sucess] = "Successfully created new user #{user.username} with ID #{user.id}"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
  end

end
