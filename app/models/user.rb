class User < ApplicationRecord
  has_many :votes
  validates :name, presence: true, uniqueness: { case_sensitive: false },
    length: { in: 6..20 }, format: { with: /(\w|-){6,20}/, message: "Only letters, numbers, underscores, and dashes allowed" }

  def print_number_of_votes
    if self.votes.size != 1
      return "#{self.votes.size} votes"
    else
      return "#{self.votes.size} vote"
    end
  end

end
