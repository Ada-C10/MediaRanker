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

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = 'Work Created!'
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = 'Work could not be created!'
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
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])
    if work.nil?
      flash[:error] = "Work #{params[:id]} not found"
    else
      work.destroy
      flash[:success] = "#{work.title} deleted"
    end
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:title,:category,:publication_year,:description)
  end
end
