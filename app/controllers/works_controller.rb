class WorksController < ApplicationController

  def index
    # @work = Work.all.order(:due_date)
      @works = Work.all.order(:category)
  end

  def show
    if @work = Work.find_by(id: params[:id].to_i)
    else
      return head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    result = @work.save

    if result
      redirect_to works_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if !@work
      return head :not_found
    end
  end

  def update
    @work = Work.find(params[:id])

    result = @work.update(work_params)

    if result
      redirect_to work_path(@work)
    else
      render :edit
    end
  end

  def destroy

    @work = Work.find_by(id: params[:id])

    if @work
      @work.destroy
      redirect_to works_path
    else
      return head :not_found
    end
  end

  def gen_categories
    # CATEGORIES = ["album", "book", "movie"] # QUESTION: keep here or move?
    # constant is in model
  end

  private

  def work_params
    return params.require(:work).permit(
      :title,
      :creator,
      :publication_year,
      :description,
      :category
    )
  end
end
