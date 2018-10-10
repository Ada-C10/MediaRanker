class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  def index
    @books = Work.get_books
    @albums = Work.get_albums
    @movies = Work.get_movies
  end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
    else
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

  def destroy
    unless @work.nil?
      @work = work.destroy
      flash[:success] = "#{@work.title} deleted"
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
