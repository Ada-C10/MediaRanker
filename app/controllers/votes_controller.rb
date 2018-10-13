class VotesController < ApplicationController

  def index
  end

  def show
  end

  def new
      @vote= Vote.new
    end

    def create
    if @current_user
    work = Work.find_by(id: params[:work_id])
    @vote = Vote.new(work_id: work.id, user_id: @current_user.id) #date: Date.today)
    is_success_save = @vote.save
    redirect_to root_path
    end
  end

    private
    def vote_params
    params.require(:vote).permit(:user_id, :work_id)
    end

end
