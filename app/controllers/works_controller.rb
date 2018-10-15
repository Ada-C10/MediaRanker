class WorksController < ApplicationController

  def index
    @albums = Work.sort_works('album')
    @books = Work.sort_works('book')
    @movies = Work.sort_works('movie')
  end

  def show
    if @work = Work.find_by(id: params[:id])
      return @work
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
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:alert] = @work.errors.full_messages.to_sentence
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
      # TODO: add flash error message
      return head :not_found
    end

    result = @work.update(work_params)

    if result
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:alert] = @work.errors.full_messages.to_sentence
       #QUESTION: how to flash error messages??? error.messages?????
      render :edit
    end
  end

  def destroy
    # TODO: add flash error message

    @work = Work.find_by(id: params[:id])

    if @work
      result = @work.destroy
      if result
        flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
        redirect_to root_path
      else
        flash.now[:alert] = "something went wrong"
        render :show
      end

    else # TODO: error messages
      flash[:alert] = "not found"
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
