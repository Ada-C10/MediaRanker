class VotesController < ApplicationController

  def index
    if params[:work_id]
      work = Work.find_by(id: params[:work_id])
      @votes = work.votes
    elsif params[:user_id]
      user = User.find_by(id: params[:user_id])
      @votes = user.votes
    else
      @votes = Vote.all
    end
  end

  def show
    @vote = Vote.find_by(id: params[:id])
    if @vote.nil?
      head :not_found
    end
  end

  def new
    @vote = Vote.new
  end

  def create
    work = Work.find_by(id: params[:work_id])

    if work
      @vote = Vote.new

      if @vote.save
        redirect_to votes_path
      else
        render :new
      end
    else
      redirect_to root_path
    end

  end

end
