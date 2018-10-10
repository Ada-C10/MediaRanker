class WorksController < ApplicationController
  before_action :get_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    works = Work.all.order('vote_count DESC, title')
    @albums = works.where(category: "album")
    @books = works.where(category: "book")
    @movies = works.where(category: "movie")
  end

  def show
    if @work.nil?
      render :notfound, status: :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to works_path
    else
      flash.now[:warning] = "A problem occured: Could not create #{@work.category}"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new
    end
  end

  def edit
    if @work.nil?
      render :notfound, status: :not_found
    end
  end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path
    else
      flash.now[:warning] = "A problem occured: Could not update #{@work.category}"
      @work.errors.messages.each { |field, messages| flash.now[field] = messages }
      render :edit
    end
  end

  def destroy
    @work.destroy_votes
    @work.destroy
    redirect_to works_path
  end

  def upvote
    @current_user = User.find_by(id: session[:user_id])

    if @current_user.nil?
      flash[:warning] = "A problem occured: You must login to do that"
      redirect_back(fallback_location: root_path)
    else
      if Vote.vote_allowed?(@current_user, @work)
        Vote.add_vote(@current_user, @work)
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      else
        flash[:warning] = "A problem occured: Could not upvote"
        # @work.errors.messages[:user] = "has already voted for this work"
        # @work.errors.messages.each { |field, messages| flash.now[field] = messages }
        redirect_back(fallback_location: root_path)
      end
    end
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def get_work
    @work = Work.find_by(id: params[:id].to_i)
  end
end
