class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :upvote, :destroy]

  def index
    @albums = Work.albums.highest_rated
    @books = Work.books.highest_rated
    @movies = Work.movies.highest_rated
  end

  def show; end

  def new
    @work = Work.new
  end

  def create

    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Media Added!"
      redirect_to works_path
    else
      flash.now[:warning] = "Media not Added!"
      @work.errors.messages.each do |field, msg|
        flash.now[field] = msg
      end

      render :new
    end
  end

  def edit; end

  def update
    if @work && @work.update(work_params)
      flash[:success] = "#{@work.title} was edited."
      redirect_to work_path(@work.id)
    elsif @work
      flash.now[:warning] = @work.errors.messages
      render :edit, status: :bad_request
    end
  end

  def destroy
    unless @work.nil?
      @work.destroy
      flash[:success] = "#{@work.title} deleted"
      redirect_to works_path
    end
  end

  def upvote
    if @work.upvote(@current_user)
      flash[:success] = "Vote successful."
    else
      flash[:warning] = "Unable to submit vote"
    end

    redirect_back fallback_location: works_path
  end

  def top_media
    @movies = Work.movies.highest_rated.limit(10)
  end

  private

  def find_work
    @work = Work.find_by_id(params[:id])

    if @work.nil?
      flash.now[:warning] = "Cannot find the media #{params[:title]}"
      render :notfound
    end
  end

  def work_params
    params.require(:work).permit(:category, :movies, :title, :creator, :publication_year, :description)
  end

end
