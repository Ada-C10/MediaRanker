class WorksController < ApplicationController


  def index
    @albums = Work.where(category: 'Album')
    @books = Work.where(category: 'Book')
    @movies = Work.where(category: 'Movie')
  end

  def show
    @work = Work.find_by(id: params[:id])
    @trips = @work.trips
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
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end


  def update
    work = Work.find_by(id: params[:id])
    if work.update(work_params)
      redirect_to works_path
    else
      head :not_acceptable
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    work.destroy
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(
      :category,
      :title,
      :creator,
      :pub_year,
      :description,
      vote_ids: []
    )
  end
end
