class VotesController < ApplicationController

  def index

    @work = Work.find_by(id: params[:work_id])

    unless @work
      head :not_found
    end
  end
end
