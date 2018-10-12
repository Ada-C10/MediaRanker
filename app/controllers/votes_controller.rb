class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create # TODO: add checks from destroy for sessions + flash
    # @vote = Vote.new(work_id: params[:work_id])

    @vote = Vote.upvote(work_id: params[:work_id])

    result = @vote.save

    if result
       flash[:success] = "Successfully upvoted!"
       redirect_to root_path
    end

    # if result
    #   flash[:success] = "Successfully created #{@work.category} #{@work.id}"
    #   redirect_to work_path(@work.id)
    # else
    #   flash.now[:alert] = "something went wrong" #QUESTION: how to flash error messages??? error.messages?????
    #   render :new
    # end
  end

  # private

  # def vote_params
  #   return params.require(:vote).permit(
  #     :user_id,
  #     :work_id
  #   )
  # end
end
