class VotesController < ApplicationController
  before_action :find_work, only: [:create, :destroy]

  def create
    if session[:user_id] && @work.has_no_vote_by?(@current_user)
      if Vote.create(user_id: session[:user_id], work_id: params[:work_id])
        flash[:success] = "Successfully upvoted!"
      else
        flash[:failure] = "Something bad happened. Vote not created."
      end
    elsif session[:user_id]
      flash[:warning] = "Vote not created. You have already upvoted this work."
    else
      flash[:warning] = "Vote not created. You must be logged in to do that!"
    end
    redirect_to work_path(params[:work_id].to_i)
  end

  def destroy
    @vote = Vote.find_by(id: params[:id].to_i)
    if session[:user_id] && @work.has_no_vote_by?(@current_user)
      flash[:warning] = "Vote not deleted. You haven't yet upvoted this work."
    elsif session[:user_id]
      if @vote.destroy
        flash[:success] = "Successfully removed upvote!"
      else
        flash[:failure] = "Something bad happened. Vote not deleted."
      end
    else
      flash[:warning] = "Vote not deleted. You must be logged in to do that!"
    end
    redirect_to work_path(params[:work_id].to_i)
  end


  private

# Filter
  def find_work
    @work = Work.find_by(id: params[:work_id].to_i)
    if @work.nil?
      flash.now[:warning] = 'Cannot find the work'
      render :notfound, status: :not_found
    end
  end

end
