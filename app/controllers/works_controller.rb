class WorksController < ApplicationController

  before_action :sorted_media, only: [:index, :main]
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
  end

  def show
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
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    if @work.update(work_params)
      redirect_to works_path
    else
      head :not_acceptable
    end
  end

  def destroy

    @work.destroy
    redirect_to works_path
  end

  def main
    @albums = @albums[0..9]
    @books = @books[0..9]
    @movies = @movies[0..9]

    @media = sort_by_votes(Work.all).first
  end

  def upvote

    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      vote = Vote.find_by(user: user, work: @work)

      if vote
        flash[:warning] = "Cannot upvote the same media twice."
      else
        flash[:success] = "Successfully voted for #{@work.title}"
        Vote.create(user: user, work: @work)
      end

    else
      flash[:danger] = "Must be logged in to vote!"
    end
    redirect_back(fallback_location: root_path)
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

  def sort_by_votes(medias)
    return medias.sort_by{ |media| -media.votes.length }
  end

  def sorted_media
      @albums = sort_by_votes(Work.where(category: 'album'))
      @books = sort_by_votes(Work.where(category: 'book'))
      @movies = sort_by_votes(Work.where(category: 'movie'))
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
