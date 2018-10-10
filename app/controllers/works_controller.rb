class WorksController < ApplicationController

  def index
      # we separate/list works by category type
      @albums = Work.where(category: 'album')
      @books = Work.where(category: 'book')
      @movies = Work.where(category: 'movie')
  end

  def show
    if @work = Work.find_by(id: params[:id])
      return @work
    else
      return head :not_found
    end

    # @votes = @work.votes ??
  end

  def new
    @work = Work.new
  end

  def create # TODO: add checks from destroy for sessions + flash
    @work = Work.new(work_params)

    result = @work.save

    if result
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:alert] = "something went wrong" #QUESTION: how to flash error messages??? error.messages?????
      render :new
    end
  end

  def edit # TODO: add checks from destroy for sessions + flash
    @work = Work.find_by(id: params[:id])
  end

  def update
    @work = Work.find_by(id: params[:id])

    # can't update something if it doesn't exist
    if !@work
      return head :not_found
    end

    result = @work.update(work_params)

    if result
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:alert] = "something went wrong" #QUESTION: how to flash error messages??? error.messages?????
      render :edit
    end
  end

  def destroy

    @work = Work.find_by(id: params[:id])

    if @work && session[:user_id] # TODO: CHECK THIS B/C NOW WE HAVE SESSIONS IN THA MIX
      result = @work.destroy
      if result
        flash[:success] = "Successfully destroyed #{@work.category} #{work.id}"
        redirect_to root_path
      else
        flash.now[:alert] = "something went wrong" #QUESTION: how to flash error messages??? error.messages?????
        render :show
      end

    elsif !@work && session[:user_id]
      #QUESTION: add flash alert not found???
      return head :not_found

    elsif @work && !session[:user_id] # QUESTION: needed???
      flash[:error] = "You must be logged in to delete something!" #NOTE: this isn't true on the model site...
      redirect_back(fallback_location: root_path)
    end
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
