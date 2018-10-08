class VotesController < ApplicationController

  def index
    @votes = Vote.all
  end

  def show
    @vote = Trip.find_by(id: params[:id])
    if @vote.nil?
      head :not_found
    end
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new
    if @vote.save
      redirect_to votes_path
    else
      render :new
    end
  end

end
