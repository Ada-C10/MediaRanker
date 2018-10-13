class ApplicationController < ActionController::Base
  before_action :find_user
  #all controllers inherit from this file

  private

  def find_user
      @current_user = User.find_by(id: session[:user_id]) #finds current user and now can use in the application layout, can use this instance var throughout program
  end
end
