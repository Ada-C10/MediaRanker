class WorksController < ApplicationController
before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
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


  def show
    if @work.nil?
      head :not_found
    end
  end

  def edit
  end

  def update
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @work.destroy
    redirect_to works_path
  end


  private

  def work_params
    return params.require(:work).permit(
      :title,
      :published_year,
      :category,
      :creator,
      :description
    )
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

end
