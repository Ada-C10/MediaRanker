class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]
  def upvote
    # Not working :(
    if @current_user.nil?
      flash[:danger] = "Must be logged in to vote"
      redirect_to root_path
    else
      # Create new vote
      vote = Vote.new
      # Add attributes
      vote.work_id = @work.id
      vote.user_id = @current_user.id
      vote.date_created = Date.today
      # Shovel into work and user vote collections
      @work.votes << vote
      @current_user.votes << vote
      redirect_to work_path
    end
  end

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
      flash.now[:danger] = 'Work not created!'
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new # show the new work form view again
    end
  end

  def update
    if @work && @work.update(work_params)
      redirect_to work_path(@work.id)
    elsif @work
      render :edit
    end
  end

  def edit
  end

  def show
    @work_votes = @work.votes
  end

  def destroy
    unless @work.nil?
    # Flash notice for success/failure
      @work.destroy
      flash[:success] = "#{@work.title} deleted"
      redirect_to root_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    id = params[:id].to_i
    @work = Work.find_by(id: id)
    if @work.nil?
      flash.now[:danger] = "Cannot find the work #{params[:id]}"
      render :notfound
    end
  end

end
