class VotesController < ApplicationController

  def index
      @votes = Vote.all
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
    if @vote.save
      flash[:success] = "Congratulations - you successfully voted!"
      redirect_to works_path
    else
      flash[:error] = "Snap! Your vote wasn't counted.  What else is new in Amercia..."
      redirect_to works_path
    end
  end
end
