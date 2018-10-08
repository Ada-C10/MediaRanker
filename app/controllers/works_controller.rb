class WorksController < ApplicationController

  def index
    @works = Work.all.order(:title)
  end

  def show
    id = params[:id]
    @work = user.find_by(id: id)

    if id == nil
      render :not_found, status: :not_found
    end

  end

  def edit
    id = params[:id]
    @work = Work.find_by(id: id)
  end

  def new
    @work = Work.new
  end

  def update
    id = params[:id]
    @work = Work.find_by(id: id)
    @work.update(work_params)

    if @work.save
      redirect_to work_path # go to the index so we can see the book in the list
    else
      render :new
    end
  end

  def create
    @work = Work.new(:id)
    # @task = Task.new(name: params[:task][:name], description: params[:task][:description], due: params[:task][:due]) #instantiate a new book
    if @work.save # save returns true if the database insert succeeds
      redirect_to work_path # go to the index so we can see the book in the list
    else # save failed :(
      render :new # show the new book form view again
    end
  end

  def destroy
    id = params[:id]
    @work = Work.find_by(id: id)
    if @work.destroy
      redirect_to root_path
    end
  end

  private
  def user_params
    return params.require(:work).permit(:title)
  end

end
