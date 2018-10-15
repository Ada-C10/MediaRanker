class ApplicationController < ActionController::Base

  before_action :find_existing_user

  private

  def find_existing_user
    @existing_user = User.find_by(id: session[:user_id])
  end
  
end
