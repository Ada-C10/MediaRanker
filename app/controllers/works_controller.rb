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
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
    else
      flash.now[:error] = "Invalid work data"
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    work = Work.find_by(id: params[:id])

    if work.update(work_params)
      flash[:success] = "Successfully updated work \"#{work.title}\""
      redirect_to work_path(work)
    else
      flash.now[:error] = "Invaid book data"
      render :edit, status: :bad_request
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.destroy
      flash[:success] = "Successfully destroyed work \"#{@work.title}\""
      redirect_to works_path

    else
      redirect_back(fallback_location: home_path)
    end

  end

  private


  def work_params
    return params.require(:work).permit(
      :title,
      :creator,
      :category,
      :publication_year,
      :description
    )
  end

end
