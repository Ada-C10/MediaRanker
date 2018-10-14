class VotesController < ApplicationController

  def create
    if params[:work_id]
      work = Work.find_by(id: params[:work_id])

      @vote = work.votes.new
      @vote.user_id = @current_user.id

    else
      @vote = Vote.new
    end

    if @vote.save
      redirect_to work_path(id: work.id)
    else
      redirect_back fallback_location: root_path
    end
  end

end
