class VotesController < ApplicationController

  def create
    id = params[:work_id].to_i
    @work = Work.find_by(id: id)

    if @current_user
    @work.upvote(user_id: @current_user.id)
      if @work.save
        flash[:success] = "Your vote was added"
        redirect_to works_path
      else
        flash[:warning] = "Your can only vote once for this work"
        redirect_to works_path
      end
    elsif @current_user.nil?
    flash[:warning] = "You must be logged in to vote"
    redirect_to works_pa
    redirect_to(work_path(@work.id))
   end
  end

end

private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
