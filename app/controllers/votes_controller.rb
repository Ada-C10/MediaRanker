class VotesController < ApplicationController
  def create
    id = params[:work_id].to_i
    if @work.upvote(@current_user)
      flash[:success] = "Vote successful."
      redirect_to root_path
    else
      flash[:warning] = "Unable to submit vote"
      redirect_back fallback_location: root_path
    end
  end
end
