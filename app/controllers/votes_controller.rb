class VotesController < ApplicationController

# This might not work at all
  def create
    if session[:user_id]
      Vote.create(user_id: session[:user_id], work_id: params[:work_id])
      flash[:success] = "Successfully upvoted!"
    else
      flash[:failure] = "Vote not created"
    end
    redirect_to work_path(params[:work_id].to_i)
  end

end
