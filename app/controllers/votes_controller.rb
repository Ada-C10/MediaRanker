class VotesController < ApplicationController
  def create #work's vote
    @vote = Vote.new(vote_params)
    if @vote.save # save returns true if the database insert succeeds
      redirect_to root_path
    else # save failed :(
      show error message#stay at work's show page
    end
  end




  private

  def vote_params
    return params.require(:work).permit(:category, :title, :creator, :published_year, :description)
  end
end
