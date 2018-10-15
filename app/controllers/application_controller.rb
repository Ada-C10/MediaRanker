class ApplicationController < ActionController::Base

  def find_logged_in_user
    @logged_in_user = User.find_by(id: session[:user_id])
  end
end
