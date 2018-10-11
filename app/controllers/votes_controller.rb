class VotesController < ApplicationController
  include VotesHelper

  def create
    @vote = Vote.new(
      user_id: session[:user_id],
      work_id: params[:work_id]
    )

    if @vote.valid?

      @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to works_path

    else

      flash[:error] = "A problem occured: Could not upvote. " + get_error_message(@vote)

      redirect_back(fallback_location: home_path)
    end


  end
end
