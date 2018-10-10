class WorksController < ApplicationController
  def index
    @work = Work.all
  end

  # we should actually make them inactive instead of deleting them
  # options: delete it's associated votes, will user still exist? yes if you use: user has many works through votes, and not belongs to
  def destroy
    work = Work.find_by(id: params[:id].to_i)
    work.destroy
    redirect_to root_path
  end

  def edit
    @work = Work.find(params[:id].to_i)
  end


  def update
    @work = Work.find_by(id: params[:id].to_i)
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def show
    id = params[:id].to_i
    @work = Work.find_by(id: id)
    if @work.nil?
      render :notfound, status: :notfound
    end
  end

  def new
    @work = Work.new
  end


  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:sucess] = "#{@work.category} added sucessfully"
      redirect_to works_path
    else
      flash.now[:warning] = "#{@work.category} not created"
      render :new
    end
  end

  def upvote
  end

  private
  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end
