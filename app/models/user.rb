class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  validates :user_name, presence: true, length: { in: 5..20 }
end
