class VotesController < ApplicationController

  def create

    user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:work_id])

    @vote = Vote.new(user: user, work: work)
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back fallback_location: root_path
    elsif !user
      flash[:failure] = "A problem occurred: You must log in to do that."
      redirect_back fallback_location: root_path
    else
      flash[:failure] = "A problem occurred: Could not upvote."
      redirect_back fallback_location: root_path
    end
  end
end
