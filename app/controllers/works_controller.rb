class WorksController < ApplicationController
  def home
    @current_user = User.find_by(id: session[:user_id])
    # nil if not logged in, or User model if they are logged in
  end

  def index
  end

  def show
    @work = Work.find(params[:id].to_i)
    if @work.nil?
      render :notfound, status: :not_found
    end
  end

  def new
  end
end
