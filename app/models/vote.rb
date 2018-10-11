class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work, counter_cache: true




  # def self.total_votes(work_id)
  #   # Vote.count(work_id: work_id)
  #   total_votes = Vote.where(work_id: work_id)
  #   total_votes = total_votes.length
  #   return total_votes
  # end

#slow
#get all works
#each work get votes
#then sort


#fast way, sort votes in the model


end
