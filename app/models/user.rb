class User < ApplicationRecord
  has_many :votes
  validates :username, uniqueness: true, length: { in: 1..20}

end
