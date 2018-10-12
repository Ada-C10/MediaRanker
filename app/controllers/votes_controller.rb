class VotesController < ApplicationController

  # def new
  #   @vote = Vote.new
  # end

  def create # TODO: add checks from destroy for sessions + flash
    # @vote = Vote.new(work_id: params[:work_id])

    # redirect_to root_path

    if find_logged_in_user() # hi, are you logged in?

      # @work_id = Work.find_by(id: params[:work])
      @work_id = Work.find_by(id: params[:work_id])
      @user_id = find_logged_in_user()

      @vote = Vote.new(work: @work_id, user: @user_id)

      result = @vote.save

      if result
        flash[:success] = "Successfully upvoted!"
        redirect_to root_path
      else
        flash[:alert] = "something went wrong"
        redirect_to work_path(1)
      end

    else flash[:alert] = "you must be logged in to vote"
      redirect_to work_path(1)
    end

    # redirect_to root_path

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
  #     # :user_id,
  #     :work_id
  #   )
  # end
end
