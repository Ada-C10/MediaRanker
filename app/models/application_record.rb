class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def get_date
    return self.created_at.strftime('%h %d, %Y')
  end

  def get_num_votes
    return self.votes.count
  end

end
