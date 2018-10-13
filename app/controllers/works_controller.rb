class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]
  # Update vote total after upvote
  # after_action :calculate_vote_total, only: [:upvote, :create]

  def upvote
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
      # Shovel into work and user vote collections
      @work.votes << vote
      # Could not make votes_count update properly :(.
      #Tried starting it at 0/adding one each time there's a vote
      # And a few other techniques
      @work.votes_count = @work.votes.length
      # @work.votes_count = Vote.count(:conditions => "work_id = #{@work.id}"
      # Might not need this line as it's alread attached to
      # The user via foreign key
      @current_user.votes << vote
      redirect_back fallback_location: root_path
    end
  end

  def index
    @works = Work.all
    # This sorts the works but it would have been nice to do it by the vote_count attribute 
    @movies = @works.select { |work| work.category == "movie" }.sort_by { |work| work.votes.count }.reverse
    @albums = @works.select { |work| work.category == "album" }.sort_by { |work| work.votes.count }.reverse
    @books = @works.select { |work| work.category == "book" }.sort_by { |work| work.votes.count }.reverse
  end


  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    # @work.vote_count = Vote.count(:conditions => "work_id = #{@work.id}"
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
