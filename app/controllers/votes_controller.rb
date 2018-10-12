class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def new
    user = @logged_in_user
    work = Work.find_by(id: params[:work_id])
    if user
      @vote = @work.votes.new(user)
    else
      flash[:error] = "Must be logged in to vote."
    end
  end

  def create
    work = Work.find_by(id: params[:work_id])
    user = @logged_in_user
    @vote = Vote.new(work_id: work.id, user_id: user.id)
    # raise
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(params[:work_id])
    else
      flash[:error] = "You can only vote once for a work."
      redirect_back(fallback_location: work_path(params[:work_id]))
    end
  end
end
