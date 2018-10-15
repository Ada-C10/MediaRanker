class VotesController < ApplicationController
  def new
    @vote = Vote.new
  end

  def index
    @votes = Vote.all
  end

  def create
    @work = Work.find_by(id: params[:id])
    vote = Vote.new(user_id: @current_user.id, work_id: @work.id)
    if @current_user.nil?
      flash[:warning] = "You must be logged in to vote"
      redirect_to root_path
    else
      upvote = Vote.new(user_id: @current_user.id, work_id: @work.id)
      vote.save
      flash[:message] = "Vote added to #{@work.title}"
    end
  end

  def destroy
    unless @vote.nil?
      @vote.destroy
      flash[:success] = "Vote deleted"
      redirect_to root_path
    end
  end

end
