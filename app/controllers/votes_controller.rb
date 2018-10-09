class VotesController < ApplicationController
  def index
    # If there is a works id for the vote
    if params[:works_id]
      # Find the work
      @work = Work.find_by(id: params[:works_id])
      # Show only votes for that work on index
      @votes = @author.votes
      # If there's a user id for the vote
    elsif params[:user_id]
      # Find the user
      @user = User.find_by(id: params[:user_id])
      # Show only votes for that user on index
      @votes = @user.votes
    else
      @votes.all 
    end

  end
end
