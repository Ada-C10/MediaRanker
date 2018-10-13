class VotesController < ApplicationController
  def create
    id = params[:work_id].to_i
    @work = Work.find(id)
    ## Figure out how to get a user of a session.
    ## user =
    if @work.upvote(user) == false
      flash[:error] = "A problem occurred: Could not create #{@work.category} #{@work.title}: has already been taken"
    else
      flash[:sucess] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path
    end
  end
end
