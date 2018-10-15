class VotesController < ApplicationController

  def new
  end

  def create
    work = Work.find_by(id: params[:work_id])
    user = User.find_by(id: session[:user_id])

    if user
      had_voted = false

      user.votes.each do |vote|
        if vote.work_id == work.id
          had_voted = true
        end
      end

      @vote = Vote.new(work_id: work.id, user_id: user.id)
      if had_voted
        flash[:error] = "You have already voted for this media."
        redirect_to work_path(work.id)
      elsif @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_to work_path(work.id)
      else
        flash[:error] = "There was an error."
        redirect_to work_path(work.id)
      end
    else
      flash[:error] = "You must be logged in to vote!"
      redirect_to work_path(work.id)
    end
  end
end
