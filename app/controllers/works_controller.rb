class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  def main
    @works = Work.all
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end

  def index
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end

  def show
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def create
    @work = Work.new(work_params)

    if @work.save
        redirect_to @work, notice: "#{@work.title} was successfully created."
    else
        render :new
    end
  end

  def update

    if @work.update(work_params)
        redirect_to @work, notice: "#{@work.title} was successfully updated."
    else
        render :edit
    end
  end

  def destroy
    @work.destroy
      redirect_to works_url, notice: 'Work was successfully deleted.'
  end



  private
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    end
end
