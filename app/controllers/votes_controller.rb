class VotesController < ApplicationController
  def index
  end
  # need to add upvote as a column
  def upvote
    @vote = Vote.new
    # += 1?
    @vote.quantity = 1
    @vote.user = params[:user_id]
    @vote.work = params[:work_id]
    if @vote.save
      redirect_back fallback_location: works_path
    else
      puts "#{@vote.errors}"
    end
  end
end
