class WorksController < ApplicationController

  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
    @movies = (Work.where(category: "movie")).ordering
    @albums = (Work.where(category: "album")).ordering
    @books = (Work.where(category: "book")).ordering

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
    # debugger
    filtered_work_params = work_params()
     @work = Work.new(filtered_work_params)
      if @work.save
        flash[:success] = "Successfully created #{@work.category}!"
        redirect_to works_path
    else
      flash.now[:error] = "Could not create #{@work.category}"
      render :new, status: :bad_request
    end
  end

  def edit

  end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated!"
      redirect_to work_path(@work.id)
    else
      # flash.now[:error] = "Invalid work data"
      render :edit, status: :bad_request
    end
  end

  def destroy
    @work.destroy

    flash[:success] = "Successfully deleted work \"#{@work.title}\""
    redirect_to works_path
  end

  def upvote
    vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])
    if vote.save
      flash[:success] = "Successfully voted!"
    else
      flash[:error] = "Couldn't record vote, sowry!"
    end
    redirect_back(fallback_location: root_path)
  end

  private
  def work_params
    return params.require(:work).permit(
      :title,
      :publication_year,
      :description,
      :creator,
      :category
    )
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
