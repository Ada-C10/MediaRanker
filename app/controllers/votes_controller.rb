class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    session[:user_id] != nil ? user_logged_in = true : user_logged_in = false

    if user_logged_in
      # does_vote_exist = Vote.where(user_id: session[:user_id], work_id: params[:work_id])

      # if does_vote_exist
      #   flash.now[:error] = "A problem occurred: Could not upvote"
      #   redirect_to work_path(params[:work_id])
      # else
        @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])
        @vote.save
        flash[:sucess] = "Successfully upvoted"
        redirect_to work_path(params[:work_id])
      # end
    else
      flash[:error] = "You must be logged in to vote"
      redirect_to new_session_path
    end
  end
end
