class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to works_path
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
    end

  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
    end

    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      head :not_found
    end

    if work.destroy
      # TODO change this to root path (for the homepage)
      redirect_to works_path
    else
      render :show
    end
  end


  def welcome
    @works = Work.all
  end



private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
