class WorksController < ApplicationController
  before_action :get_work, only: [:show, :edit, :update, :destroy, :upvote]
  def get_work
    @work = Work.find_by(id: params[:id].to_i)
  end

  def index
    @books = Work.all.where(category: "book")
    @movies = Work.all.where(category: "movie")
    @albums = Work.all.where(category: "album")
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
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit
    end
  end

  def destroy
    # Delete all votes that reference this work first
    @work.destroy
    redirect_to works_path
  end

  def upvote
    @current_user = User.find_by(id: session[:user_id])

    if @current_user.nil?
      flash.now[:warning] = "A problem occured: You must login to do that"
      redirect_back(fallback_location: root_path)
    else
      if Vote.vote_allowed?
        Vote.create(date: Date.current, user_id: @current_user.id, work_id: @work.id)
        flash[:success] = "Successfully upvoted!"
        redirect_to works_path
      else
        flash.now[:warning] = "A problem occured: Could not upvote"
      end
    end
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
