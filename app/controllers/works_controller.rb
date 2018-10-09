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

  def create # TODO: add checks from destroy for sessions + flash
    @work = Work.new(work_params)

    result = @work.save

    if result
      redirect_to works_path
    else
      render :new
    end
  end

  def edit # TODO: add checks from destroy for sessions + flash
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

    if @work && session[:user_id] # TODO: CHECK THIS B/C NOW WE HAVE SESSIONS IN THA MIX
      @work.destroy
      flash[:success] = "Successfully destroyed #{work.category} #{work.id}"
      redirect_to root_path

    elsif !@work && session[:user_id]
      return head :not_found

    elsif @work && !session[:user_id]
      flash[:error] = "You must be logged in to delete something!" #NOTE: this isn't true on the model site...
      redirect_back(fallback_location: root_path)
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
