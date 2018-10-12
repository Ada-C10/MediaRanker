class ApplicationController < ActionController::Base
  before_action :find_user, :find_work

  def find_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def find_work
    work = Work.find_by(id: params[:id])
  end

end
