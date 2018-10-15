class VotesController < ApplicationController
  def create
    if @current_user
      work = Work.find_by(id: params[:work_id])
      @vote = Vote.new(work_id: work.id, user_id: @current_user.id)
      return @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path
    else
      flash[:error] = "Can't vote twice"
    end
  end
end

  # if @work.upvote(@current_user) == false
