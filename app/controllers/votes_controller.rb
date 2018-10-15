class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create

    work = Work.find_by(id: params[:work_id])
    user = User.find_by(id: session[:user_id])

    if user
      @vote = Vote.new(work_id: work.id, user_id: user.id)

      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_to works_path
      else
        flash[:error] = "You can't vote!"
        redirect_to works_path
      end
    else
      redirect_to root_path
    end
  end

  private
  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end

end
