class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    work = Work.find(params[:id])
    if work.update(work_params)
      flash[:succes] = "Successfully updated \"#{work.title}\""
      redirect_to work_path(work.id)
    else
      flash.now[:error] = "Invalid data entered"
      render :edit, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])
    if work
      work.destroy
      flash[:success] = "Successfully deleted #{work.title}"
      redirect_to works_path
    else
      flash[:error] = "#{work.title} not deleted"
      redirect_back(fallback_location: root_path)
    end
  end



  private

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
