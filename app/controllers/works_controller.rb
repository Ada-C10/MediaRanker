class WorksController < ApplicationController
  before_action :get_work, only: [:show, :edit]
  def get_work
    @work = Work.find_by(id: params[:id].to_i)
  end

  def index
    @books = Work.all.where(category: "book")
    @movies = Work.all.where(category: "movie")
    @albums = Work.all.where(category: "album")
  end

  def show
    if @work.nil?
      render :notfound, status: :not_found
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
  end

  def update
  end

  def destroy
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
