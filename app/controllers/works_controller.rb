class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @albums = Work.by_category("album")
    @books = Work.by_category("book")
    @movies = Work.by_category("movie")
  end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to works_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @work && @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    elsif @work
      render :edit
    end
  end

  def destroy
    if !@work.nil?
      @work.destroy_votes
      @work.destroy
      redirect_to root_path
    end
  end

  def upvote
    if @current_user.nil?
      flash[:warning] = "A problem occured: You must login to do that"
      redirect_back(fallback_location: root_path)
    else
      if Vote.vote_allowed?(@current_user, @work)
        Vote.create(date: Date.current, user_id: @current_user.id, work_id: @work.id)
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      else
        flash[:warning] = "A problem occured: Could not upvote"
        @work.errors.add(:user, "has already voted for this work")
        @work.errors.messages.each { |field, messages| flash[field] = messages }
        redirect_back(fallback_location: root_path)
      end
    end
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      render :notfound, status: :not_found
    end
  end
end
