require 'pry'
class VotesController < ApplicationController
  def create
    id = params[:work_id].to_i
    @work = Work.find_by(id: id)
    binding.pry
    if @work.upvote(@current_user)
      flash[:success] = "Vote successful."
      redirect_to work_path(id)
    else
      flash[:warning] = "Unable to submit vote #{vote.error.mess}"
      redirect_to work_path(id)
    end
  end
end
