class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    id = params[:id].to_i
    @work = Work.find(params[:id].to_i)

    if id.nil?
      render :notfound
    end
  end

  def new
    @work = Work.new
  end

  def edit
    id = params[:id].to_i
    @work = Work.find(params[:id].to_i)
  end

  def update
    work = params[:id].to_i
    @work = Work.find_by(id: id)
    @work.update(vote_params)

    if @work.save
      redirect_to votes_path
    else
      render :new
    end
  end

  def create
    @work = Work.new(vote_params)
    if @vote.save # save returns true if the database insert succeeds
      redirect_to root_path # for now
    else # save failed :(
      render :new # show the new work from view again
    end
  end

  def upvote
    id = params[:id].to_i
    if @work.upvote = false
      flash[:error] = "A problem occurred: Could not create #{self.category}. #{self.title}: has already been taken"
    else
      @work.update.save
      flash[:sucess] = "Successfully created #{self.category} #{self.id}"
      redirect_to work_path
    end
  end

  def destroy
    id = params[:id].to_i
    @work = Work.find_by(id: id)
    if @work.destroy
      redirect_to root_path
    end
  end




  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :published_year, :description)
  end
end
