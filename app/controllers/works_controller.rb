class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]
  after_action :return_to, only: [:main, :index, :show, :new, :edit]

  def main
    @top_ten_lists = Work.top_ten_lists
  end

  def index
    @media_lists = Work.media_lists
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
        flash[:warning] = "A problem occurred: Could not create #{@work.category}"
        flash.now

        render :new
    end
  end

  def update

    if @work.update(work_params)
        flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
        redirect_to work_path(@work.id)
    else
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
