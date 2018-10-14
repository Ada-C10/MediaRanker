class VotesController < ApplicationController

  def create
    id = params[:work_id].to_i
    @work = Work.find_by(id: id)
    if @current_user
    @work.upvote(user_id: @current_user.id)
    redirect_to work_path(@work.id)
    else
      flash.now[:warning] = "You mustbe logged in to vote"
    end
  end

end

private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
