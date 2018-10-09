class WorksController < ApplicationController


  def index
    # Order by vote count?
    @works = Work.all
    @movies = @works.select { |work| work.category == "movie" }
    @albums = @works.select { |work| work.category == "album" }
    @books = @works.select { |work| work.category == "book" }
  end


  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = 'Work Created!'

      redirect_to root_path # go to the index so we can see the book in the list
    else # save failed :(
      flash.now[:error] = 'Work not created!'
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new # show the new book form view again
    end
  end

  def update
      @work = Book.find_by(id: params[:id].to_i)
      if @work.update(work_params)
        redirect_to work_path(@work.id)
      else
        render :edit
      end
    end

  def edit
    id = params[:id].to_i
    @work = Work.find_by(id: id)
  end

  def show
    id = params[:id].to_i
    @work = Work.find_by(id: id)

    if @work.nil?
      render :notfound, status: :not_found
    end
  end

  def destroy
    # Flash notice for success/failure
    id = params[:id].to_i
    work = Work.find_by(id: id)
    if work.nil?
      flash[:error] = "Work #{params[:id]} not found"
    else
      @deleted_work = work.destroy
      flash[:success] = "#{work.title} deleted"
    end

    redirect_to root_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
