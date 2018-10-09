class VotesController < ApplicationController
  def index
    @votes = (Vote.all).sort_by do |vote|
      vote.id
    end
  end
end
