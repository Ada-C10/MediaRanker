class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  def self.get_date(vote)
    return vote.created_at.strftime('%h %d, %Y')
  end
end
