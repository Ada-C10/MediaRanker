class WorksController < ApplicationController
  def index
    if params[:title]
      work = Work.find_by(id: params[:title])
      @works = work.titles
    else
      @works = Work.all
    end
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    # debugger
    filtered_work_params = work_params()
     @work = Work.new(filtered_work_params)
      if @work.save
        flash[:success] = "Work was successfully created with title #{@work.title}"
        redirect_to works_path
    else
      flash.now[:error] = "Invalid work data"
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.update(work_params)
      flash[:success] = "Work was successfully updated!"
      redirect_to work_path(@work.id)
    else
      # flash.now[:error] = "Invalid work data"
      render :edit, status: :bad_request
    end
  end

  private
  def work_params
    return params.require(:work).permit(
      :title,
      :publication_year,
      :description,
      :creator,
      :category
    )
  end
end
