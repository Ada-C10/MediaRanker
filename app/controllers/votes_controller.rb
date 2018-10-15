class VotesController < ApplicationController


  def create

    if find_logged_in_user() # hi, are you logged in?

      @work_id = Work.find_by(id: params[:work_id])
      @user_id = find_logged_in_user()

      @vote = Vote.new(work: @work_id, user: @user_id)

      result = @vote.save

      if result
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      else
        #TODO: gotta fix these alerts
        flash[:alert] = "something went wrong"
        redirect_back(fallback_location: root_path)
      end

    else flash[:alert] = "you must log in to vote"
      redirect_back(fallback_location: root_path)
    end
  end

end
