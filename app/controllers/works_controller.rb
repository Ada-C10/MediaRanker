class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all.order(:title)
  end

  def show; end

  def new
    @work = Work.new
  end

  def edit; end

  def destroy
    unless @work.nil?
      @work.destroy
      flash[:success] = "#{@work.title} deleted"

      redirect_to works_path
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      puts "#{@work.errors}"
      render :new
    end
  end

  def update
    if @work && @work.update(work_params)
      redirect_to work_path(@work.id)
    elsif @work
      render :edit
    end
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      flash[:warning] = 'Cannot find the work'
      redirect_to root_path
    end
  end

    def work_params
      return params.require(:work).permit(:title, :creator, :publication_year, :description, :category)
    end
end
