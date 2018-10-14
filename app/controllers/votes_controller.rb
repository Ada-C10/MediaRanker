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
      flash[:success] = "You have voted!"
      redirect_to root_path
    else
      flash[:warning] = "You must be logged in to vote"
      redirect_back fallback_location: root_path #go to same page or go to home
    end
  end

  private

  def vote_params
    return params.require(:user_id, :work_id)
  end
end
