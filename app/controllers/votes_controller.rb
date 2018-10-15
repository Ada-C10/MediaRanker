class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def new
    user = @logged_in_user
    work = Work.find_by(id: params[:work_id])
    if user
      vote = work.votes.new(user_id: user.id, work_id: work.id)
    else
      flash[:error] = "Must be logged in to vote."
    end
  end

  def create
    user = @logged_in_user
    if user == nil
      flash[:error] = "Must be logged in to vote."
      redirect_to work_path(params[:work_id])
    end

    work = Work.find_by(id: params[:work_id])

    work.votes.each do |vote|
      if vote.user_id == :user_id
        flash[:error] = "You can only vote once for a work."
        redirect_back(fallback_location: work_path(params[:work_id]))
      end
    end

    vote = work.votes.new(user_id: user.id, work_id: work.id)
    if vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(params[:work_id])
    else
      flash[:error] = "You can only vote once for a work."
      redirect_back(fallback_location: work_path(params[:work_id]))
    end
  end
end
