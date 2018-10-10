class VotesController < ApplicationController

  def create
    @vote = Vote.new(
      user_id: [1, 2, 3].sample,
      work_id: params[:work_id]
    )

    puts "THE WORK_ID IS :#{@vote.work_id}."
    puts "THE USER_ID IS :#{@vote.user_id}."

    if @vote.save
      flash[:success] = "Successfully voted for work with title \"#{Work.find_by(id: params[:work_id]).title}\""
      redirect_to works_path

    else
      flash[:error] = "A problem occured"

      redirect_back(fallback_location: home_path)
    end


  end
end
