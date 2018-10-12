class VotesController < ApplicationController

  def index
    @vote = Vote.all
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      redirect_to votes_path
    else
      render :new
    end
  end

  private

  def vote_params
    return params.require(:vote).permit(
      :vote_date,
      :user_id,
      :work_id
    )
  end
end
