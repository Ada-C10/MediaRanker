class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      render :notfound, status: :not_found
    end
  end

  def new
    @work = Work.new
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
  end

  def update
  end

  def destroy
  end

  private

    def work_params
      return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    end
end
