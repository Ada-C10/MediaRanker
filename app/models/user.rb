class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  validates :handle, presence: true, uniqueness: true
end
