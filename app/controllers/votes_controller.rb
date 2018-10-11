class VotesController < ApplicationController
  def create
    if !session[:user_id]
      flash[:warning] = "A problem occurred: You must log in to do that"
    else
      Vote.create(work_id: params[:id], user_id: session[:user_id])
      flash[:success] = "Successfully upvoted!"
    end
    redirect_back fallback_location: root_path
  end
end
