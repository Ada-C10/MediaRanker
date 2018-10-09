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
    @work = Work.new
  end

  def create
  #   formatted_work_params = work_params.dup
  #   formatted_work_params[:publication] = work_params[:publication].to_i
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end


  private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication, :category)
  end

end
