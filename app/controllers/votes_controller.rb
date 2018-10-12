class VotesController < ApplicationController
  def new
    @votes = Vote.all
  end

  def create
  end
end
