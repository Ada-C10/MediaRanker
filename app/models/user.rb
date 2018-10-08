class User < ApplicationRecord
  has_many :votes
  validates :username, uniqueness: true, length: { in: 3..20}
end
