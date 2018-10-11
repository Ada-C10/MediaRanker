class VotesController < ApplicationController

  # do we need a votes controller? - asks Dan

  def index
  end

  def new
    @vote = Vote.new
  end
end
