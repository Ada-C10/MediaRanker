class VotesController < ApplicationController

  def upvote

    if session[:user_id]
      user = User.find(session[:user_id])
      work = Work.find(params[:id])
      @votes = Vote.all
      @votes.each do |vote|
        if (vote.work_id == work.id && vote.user_id == user.id)
          flash[:failure] = "You have already voted for this!!"
          redirect_back fallback_location: root_path and return
        end
      end

      new_vote = Vote.new(user: user, work: work)

      if new_vote.save
        flash[:success] = "Successfully upvoted!"
      else
        flash[:failure] = "Could not upvote!"
      end

    else
      flash[:failure] = "You must log in to do that!"
    end
    redirect_back fallback_location: root_path
  end

end
