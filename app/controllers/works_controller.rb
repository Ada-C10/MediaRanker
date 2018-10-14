class WorksController < ApplicationController

  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def homepage

  end

  def index
    @works = Work.all
    @movies = Work.where(category: "movie")
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
  end

  def show
    # @work = Work.find_by(id: params[:id])
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

  def edit
    # @work = Work.find_by(id: params[:id])
  end

  def update
    # @work = Work.find_by(id: params[:id])

    if @work.update(work_params)
      flash[:success] = "Successfully updated \"#{@work.title}\""
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Invalid data"
      render :edit, status: :bad_request
    end
  end

  def destroy
    # @work = Work.find_by(id: params[:id])
    if @work.destroy
      flash[:success] = "Successfully destroyed \"#{@work.title}\""
      redirect_to works_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def upvote
    # if @user.id == session[:user_id]
    @work = Work.find_by(params[:id])
    # user = User.find_by(id: session[:user_id])
    # @work = Work.find_by(id: params[:id])
    # @vote = Vote.new(work_id: work.id, user_id: user.id)
    # @vote = Vote.new(user_id: @logged_in_user.id, work_id: @work.id)
    @vote = Vote.new
    @vote.user_id = @logged_in_user.id
    @vote.work_id = @work.id

    if @vote.save
      flash[:success] = "Successfully voted for #{@work.title}!"
      redirect_to works_path
    else
      flash[:error] = "Snap! Your vote wasn't counted.  What else is new in Amercia..."
      redirect_back(fallback_location: root_path)
    end

  #search for the user via session id
  #search for work via param
  #create a new vote by passing in the user id from above
  #if success, flash successfully upvoted

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

  def find_work
    @work = Work.find_by(id: params[:id])
  end

end
