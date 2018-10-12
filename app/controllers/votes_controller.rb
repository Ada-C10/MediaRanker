class VotesController < ApplicationController

  def create
    if @current_user != nil
      @vote = Vote.create(work_id: params[:work_id].to_i, user_id: @current_user.id)
      @work = Work.find(@vote.work_id)
      if @vote.valid?
        flash[:success] = "Vote placed for #{@work.title}!"
        redirect_to work_path(@vote.work_id)
      else
        flash[:warning] = "No vote was added. Looks like you have previously upvoted #{@work.title}, you sneak!!"
        redirect_to work_path(@vote.work_id)
      end
    else
      flash[:warning] = "Sorry, you must log in to place a vote."
      redirect_to request.referrer
    end
  end

end
