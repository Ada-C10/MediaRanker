class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work


  def total_votes
  end




end
