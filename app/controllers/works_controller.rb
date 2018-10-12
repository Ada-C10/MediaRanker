class WorksController < ApplicationController

  def index
    @books = Work.where(category: 'book')
    @albums = Work.where(category: 'album')
    @movies = Work.where(category: 'movie')
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
      redirect_to works_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      head :not_acceptable
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    @work.destroy
    redirect_to works_path
  end

  def upvote
    work = Work.find_by(id: params[:id])
    user = @logged_in_user
    if @logged_in_user.nil?
      flash[:error] = "A problem occured. You must be logged in to vote."
      redirect_back(fallback_location: root_path)
    elsif session[:user_id] == @logged_in_user.id
      @vote = Vote.create(
        work: work,
        user: user
      )
      flash[:success] = "Successfully upvoted!"
      redirect_to works_path
    end
  end

  private

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
