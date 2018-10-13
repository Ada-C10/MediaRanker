class VotesController < ApplicationController

  #vote status true or false
  #intermediary table

  def new
    @vote = Vote.new
  end

  def create

    if @current_user
      new_vote = {work_id: @work.id, user_id: @current_user.id}
      @vote = Vote.new(new_vote)
      @vote.save
    else
      flash[:warning] = "You must be logged in to vote"
    end
  end

  private

  def vote_params
    return params.require(:user_id, :work_id)
  end
end
