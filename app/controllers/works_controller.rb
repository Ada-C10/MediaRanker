class WorksController < ApplicationController
  before_action :find_work, only:[:show, :edit, :update, :upvote]
  before_action :find_top_media, only:[:welcome]
  before_action :find_all_works, only:[:index]

  def welcome; end

  def index; end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}!"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      render :new, status: :bad_request
    end
  end

  def edit

    if @work.nil?
      head :not_found
    end

  end

  def update
    if @work.nil?
      head :not_found
    end

    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}!"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occurred: Could not update #{@work.category}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      head :not_found
    end

    work.destroy

    flash[:success] = "Successfully destroyed #{work.category} #{work.id}!"
    redirect_to root_path
  end

  def upvote

    if @work.nil?
      head :not_found
    end

    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:error] = "A problem occurred: You must be logged in to do that"
      redirect_back(fallback_location: root_path)

    else
      @vote = Vote.new(user: @user, work: @work)

      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_to works_path
      else
        flash[:error] = "Something went wrong - cannot upvote on work more than once"
        redirect_back(fallback_location: root_path)
      end

    end

  end



private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def find_top_media
    @albums = Work.top_media('album')
    @books = Work.top_media('book')
    @movies = Work.top_media('movie')
    @spotlight = Work.spotlight
  end

  def find_all_works
    @albums = Work.get_all_works('album')
    @books = Work.get_all_works('book')
    @movies = Work.get_all_works('movie')
  end


end
