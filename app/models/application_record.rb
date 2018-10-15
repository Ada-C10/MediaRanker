class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def count_votes
    return self.votes.length
  end

end
