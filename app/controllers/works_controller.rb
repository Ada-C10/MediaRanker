class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  def index
    @books = Work.get_media("book")
    @albums = Work.get_media("album")
    @movies = Work.get_media("movie")
  end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "#{@work.title} has been added to MediaRanker."
      redirect_to work_path(@work.id)
    else
      flash.now[:warning] = "Work was not created because of the following errors:"
      render :new
    end
  end

  def edit; end

  def update
    if @work && @work.update(work_params)
      redirect_to work_path(@work.id)
    elsif @work
      render :edit
    end
  end

  def main
    @books = Work.top_ten("book")
    @albums = Work.top_ten("album")
    @movies = Work.top_ten("movie")
    @top_work = Work.top_work
  end

  def destroy
    unless @work.nil?
      @work = @work.destroy
      flash[:success] = "#{@work.title} has been deleted from MediaRanker."
      redirect_to works_path
    end
  end


  private

  def work_params
    return params.require(:work).permit(:title, :creator, :published, :description, :category)
  end

  def set_work
    @work = Work.find(params[:id])

    if @work.nil?
      flash.now[:warning] = "Cannot find the book"
    end
  end

end
