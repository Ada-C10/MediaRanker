class VotesController < ApplicationController

  def index
    @works = Work.all
  end


  def create
    unless @current_user
      flash[:error] = "must be logged in to vote"
      redirect_to request.referrer
    else
      if Vote.already_voted?(vote_params[:work_id], @current_user.id)
        flash[:error] = "You can only vote for a work once per user"
        redirect_to request.referrer
      else
        @vote = @current_user.votes.new(vote_params)
        if @vote.save
          redirect_to work_path(vote_params[:work_id])
        else
          flash[:error] = "cant save vote"
          redirect_to votes_path
        end
      end
    end
  end

  private

  def vote_params
    return params.require(:vote).permit(
      :work_id
    )
  end
end
