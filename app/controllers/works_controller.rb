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
      head :notfound
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

  def update
    @work = Work.find_by(id: params[:id].to_i)
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def destroy
    work = Work.find_by(id: params[:id].to_i)
    if work.nil?
      flash[:error] = "Work #{params[:id]} not found"
    else
      @deleted_work = work.destroy
      flash[:success] = "#{work.title} deleted"
    end

    redirect_to root_path
  end

  private
  def work_params
    return params.require(:work).permit(:id, :title, :creator, :description, :category, :publication_year)
  end


end
