class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work == nil
      head :not_found
      #render invalid_page, status: :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    filtered_params = work_params()
    work = Work.new(filtered_params)
    is_successful_save = work.save
    #if not successful re-render form, else  show all
    if is_successful_save
      redirect_to works_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    work = Work.find_by(id: params[:id])
    passenger.update
    redirect_to works_path
    #if successful save vs not, .update returns boolean?
    #redirect to show page
  end

  def destroy
    work = Work.find_by(id: params[:id])
    work.destroy
    redirect_to works_path
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
