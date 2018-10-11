class VotesController < ApplicationController
  def create
    if !session[:user_id]
      flash[:warning] = "A problem occurred: You must log in to do that"
    else
      @vote = Vote.new(work_id: params[:id], user_id: session[:user_id])
      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back fallback_location: root_path
      else
        flash[:warning] = "A problem occurred: Could not upvote"
        flash[:vote_errors] = @vote.errors.full_messages.first
        redirect_back fallback_location: root_path
      end
    end

  end
end
