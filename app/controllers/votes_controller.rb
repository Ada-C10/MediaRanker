class VotesController < ApplicationController

  def index
    @votes = Vote.all
  end


  def create
    @vote = Vote.new(user_id: current_user, work_id: params[:id])
  end
end
