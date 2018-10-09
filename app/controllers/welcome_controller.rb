class WelcomeController < ApplicationController
  def index
    @work = Work.spotlight
    @vote_count = @work.votes.length
  end
end
