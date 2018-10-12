class WorksController < ApplicationController
  def index
    @works = Work.all
  end
  def show
    id = params[:id].to_i
    @work = Work.find_by(id: id)

    if @work.nil?
      render :notfound, status: :not_found
    end
  end
  def new
    @work = Work.new
  end

  def edit
    @work = Work.find(params[:id].to_i)
  end
end
