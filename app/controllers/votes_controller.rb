class VotesController < ApplicationController

  def index
    @votes = Vote.all
  end


  def create
    @vote = Vote.create(user_id: @current_user.id, work_id: params[:id])
  end
end
