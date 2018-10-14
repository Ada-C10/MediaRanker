class WorksController < ApplicationController


  def index
    @works = Work.order(votes_count: :desc)
    @books = @works.where(category: 'book')
    @albums = @works.where(category: 'album')
    @movies = @works.where(category: 'movie')
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
      flash[:success] = "Thanks for upvoting!"
      redirect_to works_path
    else
      flash[:error] = "You can't vote for the same work twice."
      redirect_to works_path
    end
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



end
