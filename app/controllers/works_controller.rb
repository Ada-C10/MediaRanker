class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    does_work_exist = Work.find_by(title: params[:title])
    if does_work_exist
      flash[:error] = "A problem occurred: Could not create #{params[:category]}"
    else
      @work = Work.new(work_params)

      if @work.save
        flash[:success] = "#{@work.title} added sucessfully"
        redirect_to works_path
      else
        flash.now[:error] = "Invalid media entry"
        render :new, status: :bad_request
      end
    end
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
  end

  def edit
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
  end

  def update
    @work = Work.find(params[:id])
    result = @work.update(work_params)
    updated_work = Work.find(params[:id])

    if result
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occurred: Could not update #{@work.category}"
      render :edit
    end
  end

  def destroy
    work_id = params[:id]
    work = Work.find_by(id: work_id)

    if work.destroy
      flash[:success] = "Successfully destroyed #{work.category} #{work.id}"
      redirect_to root_path
    else
      flash.now[:error] = "Unable to destroy #{work.category} #{work.id}"
      render :edit
    end
  end

  private
  def work_params
    return params.require(:work).permit(
      :category,
      :title,
      :creator,
      :publication_year,
      :description
    )
  end
end
