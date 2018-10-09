class User < ApplicationRecord
  has_many :votes
  # has_many :works, through: :votes

  validates :username, uniqueness: true, length: { in: 5..20}
end
