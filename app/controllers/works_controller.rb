class WorksController < ApplicationController
  def index
    @works = Work.all.order(:title)
  end

  def main
    @works = Work.all.order(:title)
  end

  def show
    id = params[:id]
    @work = Work.find_by(id: id)

    if @work.nil?
      render :notfound, status: :not_found
    end
  end


  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
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
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])
    work.destroy
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:title)
  end
end
