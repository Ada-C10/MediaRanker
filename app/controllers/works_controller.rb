class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "#{@work.title} added sucessfully"
      redirect_to works_path
    else
      flash.now[:error] = "Invalid media entry"
      render :new, status: :bad_request
    end
  end

  private
  def work_params
    return params.require(:work).permit(
      :category,
      :title,
      :creator,
      :publication_year,
      :description
    )
  end
end
