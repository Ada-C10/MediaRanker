class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]

  def upvote
    # Must be logged in to vote
    if @current_user.nil?
      flash[:danger] = "Must be logged in to vote"
      redirect_to login_path
    else
      # Create new vote
      vote = Vote.new
      # Add attributes
      vote.work_id = @work.id
      vote.user_id = @current_user.id
      vote.date_created = Date.today
      vote.save
      # Shovel into work collection of votes
      @work.votes << vote
      # Add one to works vote count
      @work.votes_count += 1
      # @work.votes_count = Vote.count(:conditions => "work_id = #{@work.id}"
      # Shovel vote to user collection of votes
      @current_user.votes << vote
      # Send user back to where they were or to root path
      redirect_back fallback_location: root_path
    end
  end

  def index
    @works = Work.all
    @movies = @works.select { |work| work.category == "movie" }.sort_by { |work| work.votes_count }.reverse
    @albums = @works.select { |work| work.category == "album" }.sort_by { |work| work.votes_count }.reverse
    @books = @works.select { |work| work.category == "book" }.sort_by { |work| work.votes_count }.reverse
  end


  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    # @work.vote_count = Vote.count(:conditions => "work_id = #{@work.id}"
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = 'Work Created!'
      redirect_to works_path # go to the index so we can see the work in the list
    else # save failed :(
      flash.now[:danger] = 'Work not created!'
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new # show the new work form view again
    end
  end

  def update
    # If it updates, go to the work show page
    if @work && @work.update(work_params)
      redirect_to work_path(@work.id)
    elsif @work
    # If not, render the edit page
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
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description, :vote_count)
  end

  def find_work
    id = params[:id].to_i
    @work = Work.find_by(id: id)
    if @work.nil?
      flash.now[:danger] = "Cannot find the work #{params[:id]}"
      render :notfound
    end
  end

  def sort_by_vote(collection)
    if collection.empty?
      return ""
    else
      return collection.sort_by { |work| work.votes.length }.reverse
    end
  end

  # Decided to default to 0/add one for each upvote instead 
  # def calculate_vote_total
  #   if self.votes.length == 0
  #     # If no votes, set to 0
  #     self.vote_count = 0
  #   else
  #     # Otherwise set vote count
  #   self.vote_count = self.votes.length
  #   end
  #   binding.pry
  # end

end
