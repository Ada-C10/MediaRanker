class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  validates :name, presence: true, length: { in: 4..10 }
  validates :name, uniqueness: true
end
