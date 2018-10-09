class WorksController < ApplicationController
  def index
    if params[:title]
      work = Work.find_by(id: params[:title])
      @works = work.titles
    else
      @works = Work.all
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
