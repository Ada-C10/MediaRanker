class User < ApplicationRecord
  has_many :votes
  validates :name, presence: true
  validates :name, uniqueness: true, length: { in: 3..50 }

end
