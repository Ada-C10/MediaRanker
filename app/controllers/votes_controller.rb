class VotesController < ApplicationController

  def create
    work = Work.find_by(id: params[:work_id])

    vote = Vote.new(user: @user, work: work)

    if vote.save
      flash[:success] = "Successfully upvoted!"
    elsif !@user
      flash[:alert] = 'You must log in to do that'
    else
      flash[:alert] = {"upvote" => {"user": "has already voted for this work"}}
    end

    redirect_back fallback_location: root_path
  end
end
