class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show

  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find(params[:id].to_i)
  end

  def update

  end

  def create

  end

  def destroy

  end

  private

  def work_params
    return params.require(:work).permit(:id, :creator, :category, :year, :description)
  end
end
