class VotesController < ApplicationController

  def index
    @works = Work.all
  end


  def create
    @vote = @current_user.votes.new(vote_params)
    if @vote.save
      redirect_to votes_path
    else
      flash[:error] = "cant save vote"
      redirect_to votes_path
    end
  end

  private

  def vote_params
    return params.require(:vote).permit(
      :work_id
    )
  end
end
