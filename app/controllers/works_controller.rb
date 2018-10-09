class WorksController < ApplicationController
  def index
    @works = Work.order(:title)

    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
    
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)

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
      redirect_to works_path(@work_id)
    else
      render :new
    end
  end

  private
  def work_params
    return params.require(:work).permit(:id, :title, :creator, :description, :category, :publication_year)
  end


end
