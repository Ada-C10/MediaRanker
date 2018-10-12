class ApplicationController < ActionController::Base
  before_action :find_logged_in_user
    before_action :user_logged_in?, only: [:upvote]

  private

  def find_logged_in_user
    @logged_in_user = User.find_by(id: session[:user_id])
  end

  def user_logged_in?
    if @logged_in_user.nil?
      flash[:error] = "A problem occured. You must be logged in to vote."
      redirect_back(fallback_location: root_path)
    end
  end
end
