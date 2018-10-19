class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true, uniqueness: true

  WORK = ["movie", "book", "album"]

  def self.top(num)
    self.most_voted[0..(num-1)]
  end

  def self.most_voted
    self.all.sort_by{ |work| work.votes.count }.reverse
  end

end
