class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def new
    @work = Work.new
  end

  def destroy
    work = Work.find_by(id: params[:id])
    work.destroy
    redirect_to root_path
  end

  def create
  end

  def show
    work_id = params[:id]
    @work= Work.find_by(id: work_id)
    if @work.nil?
      head :not_found
    end
  end

  def update
    @work = Work.find(params[:id])
    @work.update(work_params)
    redirect_to works_path
  end


end
