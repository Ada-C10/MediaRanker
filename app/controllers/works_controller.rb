class WorksController < ApplicationController
  def home
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
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end


  private

  def work_params
    return params.require(:work).permit(:title, :creator) #TODO: update permit
  end
end
