class WorksController < ApplicationController

  def index
    @works = Work.all.order(:title)
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

    @work = Work.new(work_params())

    if @work.save
      redirect_to work_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    work = Work.find_by(id: params[:id])

    if work.update(work_params)
      redirect_to work_path(work.id)
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    @work.destroy

    redirect_to works_path
  end

  def top
  end

  private
  def work_params
    return params.require(:work).permit(
      :title,
      :category,
      :creator,
      :publication_year,
      :description
    )
  end
end
