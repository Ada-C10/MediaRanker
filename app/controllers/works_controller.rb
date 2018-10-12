class WorksController < ApplicationController

  def homepage

  end

  def index
    @works = Work.all
    @movies = Work.where(category: "movie")
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
  end

  def show
    @work = Work.find_by(id: params[:id])
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
      flash[:success] = "Congratulations - you successfully entered a piece of Media!"
      redirect_to works_path
    else
      flash.now[:error] = "The data you entered was not valid.  Please try again."
      render :new, status: :bad_request
    end
  end

  private

  def work_params
    return params.require(:work).permit(
      :title,
      :description,
      :year_published,
      :created_by,
      :category
    )
  end

end
