class VotesController < ApplicationController

  #vote status true or false
  #intermediary table

  def new
    @vote = Vote.new
  end
  def create
    @vote = Vote.new(new_vote)
    @vote.save
  end

  private

  def vote_params

  end
end
