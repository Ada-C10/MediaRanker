class VotesController < ApplicationController

  before_action :find_logged_in_user

  def create
    @vote = Vote.new
    @vote.work_id = Work.find_by(id: params[:work_id]).id


    if @logged_in_user
       @vote.user_id = @logged_in_user.id

      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_to work_path(id: @vote.work.id)
      else
        flash[:notice] = "A problem occurred: Could not upvote: user has already voted for this work"
        redirect_back fallback_location: :work_path
      end
    else
      flash[:notice] = "A problem occurred: You must log in to do that"
      redirect_back fallback_location: :works_path
      end


    end
  end


# private
#
#   def vote_params
#     return params.require(:vote).permit(
#       :work_id,
#       :user_id,
#     )
  # end
