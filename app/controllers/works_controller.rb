class WorksController < ApplicationController
  def index
    @movies = Work.category_list("movie")
    @books = Work.category_list("book")
    @albums = Work.category_list("album")
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)

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
      redirect_to works_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id].to_i)
  end

  def update
    @work = Work.find_by(id: params[:id].to_i)
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def destroy
    work = Work.find_by(id: params[:id].to_i)
    @deleted_work = work.destroy

    redirect_to works_path
  end

  def upvote
    # check if user is logged in
    # find work_id using find_by params
    # check if user has not already voted on work

      # if above true, Vote.create(user_id: current_user, work_id: params)
      # flash success message

      # else flash failure message
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
