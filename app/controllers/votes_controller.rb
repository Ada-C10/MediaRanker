class VotesController < ApplicationController

  def create
    @vote = Vote.new(work_id: work.id, user_id: user.id)

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path
    else
      flash.now[:error] = "A problem occurred: You must log in to do that"
      render :new, status: :bad_request
    end
  end


# private
#
#   def vote_params
#     return params.require(:vote).permit(
#       :work_id,
#       :user_id,
#     )
#   end
end
