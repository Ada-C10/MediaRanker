class ApplicationController < ActionController::Base
  # before anything call method to find user applied before any controller
  before_action :find_user

  private
  def find_user
    # @current_user can be used in every view
    @current_user = User.find_by(id: session[:user_id])
  end
  

end
