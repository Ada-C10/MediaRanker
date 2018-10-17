class VotesController < ApplicationController
  def create
    id = params[:work_id].to_i
    @work = Work.find_by(id: id)
    if @work.upvote(@current_user)
      flash[:success] = "Vote successful."
      redirect_back fallback_location: root_path
    else
      flash[:warning] = "Unable to submit vote #{vote.error.mess}"
      redirect_back fallback_location: root_path
    end
  end
end
