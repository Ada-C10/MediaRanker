class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by( id: params[:id])
    if @work.nil?
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create

  end



  private

  def work_params
    return params.require(:work).permit(
      :title,
      :category,
      :creator,
      :publication_year,
      :description,
    )
  end
  

end
