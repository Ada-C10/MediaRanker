class User < ApplicationRecord
  has_many :votes
  validates :username, presence: true, uniqueness: true

  def check_votes
    works_voted_for = []

    self.votes.each do
      works_voted_for << work.id
    end
  end

end
