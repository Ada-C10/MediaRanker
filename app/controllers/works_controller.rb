class WorksController < ApplicationController
  def index
    @works = Work.all
  end


  def show
    work_id = params[:id]
    find_work
    if @work.nil?
      head :not_found
    end
  end

  def new
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      @work = user.works.new
      # Same thing as above:
      # @work = Work.new(user: user)
    else
      @work = Work.new
    end
  end

  def create
    filtered_work_params = work_params()
    @work = Work.new(filtered_work_params)

    is_successful_save = @work.save

    if is_successful_save
      flash[:success] = "Successfully created new work with title \"#{@work.title}\""
      redirect_to works_path
    else
      flash.now[:error] = "Invalid work data"
      render :new, status: :bad_request
    end
  end

  def edit
    @work= Work.find_by(id: params[:id])
  end

  def update
    work = Work.find_by(id: params[:id])
    work.update(work_params)

    is_successful = work.save

    if is_successful # save returns true if the database insert succeeds
      redirect_to works_path(work.id) # go to the index so we can see the book in the list
    else # save failed :(
      render :new # show the new book form view again
    end

  end


  def destroy
    work = Work.find_by(id: params[:id])

    work.destroy

    redirect_to works_path(work.id)
  end


  private

  # Strong params: only let certain attributes
  # through
  def work_params
    return params.require(:work).permit(
      :title,
      :creator,
      :description,
      :publication_year,
      :category
    )
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

end
