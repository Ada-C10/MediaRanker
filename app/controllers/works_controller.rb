class WorksController < ApplicationController
  def index
    @work = Work.all
  end

  def delete
  end

  def edit
    @work = Work.find(params[:id].to_i)
  end

  # does not update
  def update
    @work = Work.find_by(id: params[:id].to_i)
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  # does
  def show
    id = params[:id].to_i
    @work = Work.find_by(id: id)
    if @work.nil?
      render :notfound, status: :notfound
    end
  end

  def new
    @work = Work.new
  end

  # def create
  #   @work = Work.new(work_params)
  #   if @work.save
  #     redirect_to work_path
  #   else
  #     render :new
  #   end
  # end

  def upvote
  end

  private
  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end
