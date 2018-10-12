class WorksController < ApplicationController
  before_action :user_logged_in?, only: [:upvote]

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
    @vote = Vote.new(work: work, user: user)
    if @vote.save
      flash[:notice] = "Thanks for upvoting!"
      redirect_to works_path
    else
      flash[:notice] = "You can't vote for the same work twice."
      redirect_to works_path
    end
    # if user.nil?
    #   flash[:error] = "A problem occured. You must be logged in to vote."
    #   redirect_back(fallback_location: root_path)
    # elsif user.works.include? (work)
    #   flash[:error] = "You already voted for this work."
    #   redirect_to works_path
    # elsif session[:user_id] == user.id
    #   @vote = Vote.create(
    #     work: work,
    #     user: user
    #   )
    #   flash[:success] = "Successfully upvoted!"
    #   redirect_to works_path
    # end

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

  def user_logged_in?
    if @logged_in_user.nil?
      flash[:error] = "A problem occured. You must be logged in to vote."
      redirect_back(fallback_location: root_path)
    end
  end

end
