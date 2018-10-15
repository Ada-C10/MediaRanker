class User < ApplicationRecord
  # has_many :works, through: :votes
  validates :username, presence: true, uniqueness: true
  has_many :votes

  def joining_date
    return self.created_at.strftime("%B %d, %Y")
  end
end
