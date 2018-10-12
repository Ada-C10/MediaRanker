class VotesController < ApplicationController
  def index
    @votes = Vote.all
    end
  end

  def create
    @vote = Vote.new
  end
end
