class WorksController < ApplicationController

  def index
    @works = Work.all
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
    @work = Work.new(work_params)

    if @work.save
      redirect_to works_path
    else
      render :new, status: :bad_request
    end
  end

  private

  def work_params
    return params.require(:work).permit(
      :title,
      :description,
      :year_published,
      :created_by,
      :category
    )
  end

end
