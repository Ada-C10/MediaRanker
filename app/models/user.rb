class User < ApplicationRecord
  has_many :votes

  validates :username, presence: true, uniqueness: true, allow_nil: true
end
