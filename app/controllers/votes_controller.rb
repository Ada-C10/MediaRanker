class VotesController < ApplicationController

  def index
    # if params[:work_id]
    #   work = Work.find_by(id: params[:work_id])
    #   @votes = work.votes
    # elsif params[:user_id]
    #   user = User.find_by(id: params[:user_id])
    #   @votes = user.votes
    # else
      @votes = Vote.all
    # end
  end

  def show
    @vote = Vote.find_by(id: params[:id])
    if @vote.nil?
      head :not_found
    end
  end

  # def new
  #   @vote = Vote.new
  # end

  def create

    @vote = Vote.new
    @vote.save
    # if @vote.save
    #   flash[:success] = "Congratulations - you successfully voted!"
    #   redirect_to works_path
    # else
    #   flash[:error] = "Snap! Your vote wasn't counted.  What else is new in Amercia..."
    #   redirect_to works_path
    # end

    # work = Work.find_by(id: params[:work_id])
    # user = User.find_by(id: params[:user_id])
    #
    # @vote = Vote.new(work_id: work.id, user_id: user.id)
    #
    # if @vote.save
    #   flash[:success] = "Congratulations - you successfully voted!"
    #   redirect_to votes_path
    # else
    #   flash[:error] = "Your vote wasn't tabulated.  What else is new in Amercia..."
    #   redirect_to root_path
    # end
  end
end
