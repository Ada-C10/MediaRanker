class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end


  def create
    @vote = Vote.new
  end
end
