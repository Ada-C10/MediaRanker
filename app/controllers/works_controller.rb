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
    id = params[:id].to_i
    @work = Work.find_by(id: id)
    @work.update(work_params)

    if @work.save
      redirect_to works_path
    else
      render :edit
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = "#{@work.category} is created!"

      redirect_to root_path # for now
    else # save failed :(
      flash.now[:error] = "Not created!"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new # show the new work from view again
    end
  end


  def destroy
    id = params[:id].to_i
    @work = Work.find_by(id: id)
    if @work.destroy
      flash[:success] = "#{@work.title} is deleted"
      redirect_to root_path
    end
  end
  #
  # def create
  #   @work = Work.find(params[:id])
  #   @work = User.find(params[:id])
  #   @work.votes.create
  #   redirect_to(works_path)

    #
    # if @work.upvote(@current_user)
    #   flash[:success] = "Vote successful."
    # else
    #   flash[:warning] = "Unable to submit vote"
    # end
    #
    # redirect_back fallback_location: works_path
  # end


  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :published_year, :description)
  end
end
