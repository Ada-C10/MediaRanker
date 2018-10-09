class WorksController < ApplicationController
  def index
    if params[:title]
      work = Work.find_by(id: params[:title])
      @works = work.titles
    else
      @works = Work.all
    end
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    filtered_work_params = work_params()
     @work = Work.new(filtered_work_params)
      if @work.save
        redirect_to work_path(work.id)
    else
      render :new
    end
  end

  private
  def work_params
    return params.require(:work).permit(
      :title,
      :publication_year,
      :description,
      :creator,
      :category
    )
  end
end
