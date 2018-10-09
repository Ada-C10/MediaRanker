class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
  end


  private

  def work_params
    params.require(:work).permit(:categor, :title, :creator, :publication_year, :description)
  end
end
