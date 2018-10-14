class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
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
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully created new work: #{@work.title}"
      redirect_to works_path
    else
      flash.now[:error] = "Invalid data, please try again"
      render :new , status: :bad_request
    end
  end


  def edit
  end


  def update
    if @work.update(work_params)
      redirect_to work_path
    else
      render :edit , status: :bad_request
    end
  end


  def destroy
    @work.destroy
    redirect_to homes_path
  end


  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :pub_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
