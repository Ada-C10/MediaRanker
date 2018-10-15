class VotesController < ApplicationController
  def create
    id = params[:id].to_i
    @work = Work.find_by(id: id),
    @work = User.find_by(id: id)
    @work.upvote.create
    redirect_to(works_path)
  end
end
