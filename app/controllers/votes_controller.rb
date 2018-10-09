class VotesController < ApplicationController
  def index
    # If there is a works id for the vote
    if params[:works_id]
      # Find the work
      @work = Work.find_by(id: params[:works_id])
      # Show only votes for that work on index
      @votes = @work.votes
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

  # TODO Add upvote method? Has access to id of user and work
  # If user selects the upvote button,
  # Make sure user has not already voted for the work
  # If not, add a vote
    # Create a new vote with the user set as the person who clicked the link 
    # And the work vote will increase  by one
end
