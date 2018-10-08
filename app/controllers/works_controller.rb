class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    #if nil render not found, else show page
  end

  def new
    @work = Work.new
  end

  def create
    filtered_params = work_params()
    work = Work.new(filtered_params)
    #if nil re-render form, else  show all
  end

  private

  #strong params
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
