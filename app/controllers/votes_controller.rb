class VotesController < ApplicationController

  def index

    @work = Work.find_by(id: params[:work_id])
    @votes = Vote.where(work: work)
  end
end
