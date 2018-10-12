class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]
  after_action :return_to, only: [:main, :index, :show, :new, :edit]

  def main
    @spotlight = Work.most_votes
    @top_movies = Work.top_ten('movie')
    @top_books = Work.top_ten('book')
    @top_albums = Work.top_ten('album')
    # @top_ten_lists = Work.top_ten_lists
  end

  def index
    @movies = Work.list('movie')
    @books = Work.list('book')
    @albums = Work.list('album')
    # @media_lists = Work.media_lists
  end

  def show
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def create
    @work = Work.new(work_params)

    if @work.save
        flash[:success] = "Successfully created #{@work.category} #{@work.id}"
        redirect_to work_path(@work.id)
    else
        flash.now[:warning] = "A problem occurred: Could not create #{@work.category}"
        render :new
    end
  end

  def update

    if @work.update(work_params)
        flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
        redirect_to work_path(@work.id)
    else
        flash.now[:warning] = "A problem occurred: Could not update #{@work.category}"
        render :edit
    end
  end

  def destroy
    @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
      redirect_to works_path
  end



  private
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    end

    def return_to
      session[:return_to] = request.fullpath
    end
end
