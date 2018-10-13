class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    session[:user_id] != nil ? user_logged_in = true : user_logged_in = false

    if user_logged_in
      does_vote_exist = Vote.where(user_id: session[:user_id].to_s, work_id: params[:work_id].to_s)

      if does_vote_exist == []
        @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])
        @vote.save

        work_upvoted = Work.find_by(id: params[:work_id])
        current_vote_count = work_upvoted.total_votes
        new_vote_count = current_vote_count + 1
        work_upvoted.total_votes = new_vote_count
        work_upvoted.save

        flash[:sucess] = "Successfully upvoted"
        redirect_back fallback_location: '/', allow_other_host: false
      else
        flash[:error] = "A problem occurred: Could not upvote. You've already upvoted this work."
        redirect_back fallback_location: '/', allow_other_host: false
      end
    else
      flash[:error] = "You must be logged in to vote"
      redirect_to new_session_path
    end
  end
end
