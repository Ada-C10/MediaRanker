class WorksController < ApplicationController
  def main
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)
    if @work.nil?
      render :not_found, status: :not_found
    end
  end

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = 'Work added!'
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = 'Work not added'
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new
    end

  end

  def edit
    @work = Work.find_by(id: params[:id].to_i)
  end

  def update
    @work = Work.find_by(id: params[:id])
    @work.update(work_params)
    if @work.save
      redirect_to work_path
    else
      render :new
    end
  end

  def destroy
    work = Work.find_by(id: params[:id].to_i)
    work.destroy
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:title, :publication_year, :creator, :description, :category)
  end
end
