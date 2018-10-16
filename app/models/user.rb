class User < ApplicationRecord
  has_many :votes
  validates :username, presence: true, uniqueness: true

  def self.voted_works(user_id)
    works = User.where(id: user_id)
    return works
  end
end
