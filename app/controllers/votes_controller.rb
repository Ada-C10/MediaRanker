class VotesController < ApplicationController


  def create

    if find_logged_in_user() # hi, are you logged in?

      @work_obj = Work.find_by(id: params[:work_id])
      @user_obj = find_logged_in_user()

      @vote = Vote.new(work: @work_obj, user: @user_obj)

      result = @vote.save

      if result
        flash[:success] = "Successfully upvoted!"
        redirect_to work_path(@work_obj.id)
      else
        #TODO: gotta fix these alerts
        flash[:alert] = @vote.errors
        redirect_to work_path(@work_obj.id)
      end

    else flash[:alert] = "You must be logged in to vote"
      redirect_to work_path(@work_obj.id)
    end

  end

# QUESTION: hm, make private??? is that possible? comes from work
  # private
  #
  # def vote_params
  #   return params.require(:vote).permit(
  #     # :user_id,
  #     :work_id
  #   )
  # end
end
