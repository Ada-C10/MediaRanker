class WorksController < ApplicationController

  def index
    @works = Work.featured
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

    @work = Work.new(work_params())

    if @work.save
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    work = Work.find_by(id: params[:id])

    if @work.update(work_params)
      redirect_to work_path(@work.id)
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    @work.destroy

    redirect_to works_path
  end

  def top

    @works = Work.featured
    #top media for spot light
    @top = @works.first

    # for top 10 movies
    @movies = Work.where(category: "movie")
    # sort by votes and take only 10 movies
    @movies = (@movies.sort_by { |movie| -movie.votes_count}).take(10)

    # for top 10 books
    @books = Work.where(category: "book")
    # sort by votes and take only 10 movies
    @books = (@books.sort_by { |book| -book.votes_count}).take(10)

    # for top 10 albums
    @albums = Work.where(category: "album")
    # sort by votes and take only 10 movies
    @albums = (@albums.sort_by { |album| -album.votes_count}).take(10)

  end

  def upvote
    @work = Work.find_by(id: params[:work_id])

    if @work.nil?
      head :not_found
    end

    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:error] = "Must be logged in to vote"
      redirect_back(fallback_location: root_path)
    else
      @vote = Vote.new(user: @user, work:
        @work)

        if @vote.save
          flash[:success] = "Successfully voted for this work."
          redirect_to work_path(@work)
        else
          flash[:error] = "You already voted for this work, can't vote for it again!"

        end
      end
    end



    private
    def work_params
      return params.require(:work).permit(
        :title,
        :category,
        :creator,
        :publication_year,
        :description
      )
    end

  end
