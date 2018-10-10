class WorksController < ApplicationController

  def homepage
  end

  def index
     @works = Work.all.order(category: :asc)
    # @works = Work.all
  end

  def new
    @work = Work.new
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    end
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      # flash[:success] = "Successfully created new work \"#{@work.title}\""
      redirect_to works_path
    else
      # flash.now[:error] = "Invalid work data"
      render :new,  status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    end
  end

  private

    def work_params
      return params.require(:work).permit(
        :category, :title, :creator, :description, :publication_year)
    end
end
