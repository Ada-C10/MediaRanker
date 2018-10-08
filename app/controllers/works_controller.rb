class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    #if nil render not found, else show page
  end

  def new
    @work = Work.new
  end

  def create
    filtered_params = work_params()
    work = Work.new(filtered_params)
    is_successful_save = work.save
    #if not successful re-render form, else  show all
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    work = Work.find_by(id: params[:id])
    passenger.update
    #if successful save vs not, .update returns boolean?
    #redirect to show page
  end

  def destroy
    work = Work.find_by
    #redirect to work#index (with partial rendered?)
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
