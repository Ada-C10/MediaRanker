class VoteController < ApplicationController

# This might not work at all
  def create
    if session[:user_id]
      Vote.create(user_id: session[:user_id], work_id: params[:id])
    else
      flash[:failure] = "Vote not created"
    end
  end

end
