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
    filtered_work_params = work_params()
    @work = Work.new(filtered_work_params)

    is_successful_save = @work.save

    if is_successful_save
      redirect_to works_path
    else
      render :new, status: :bad_request
    end

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
