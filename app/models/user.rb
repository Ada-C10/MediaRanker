class User < ApplicationRecord
  has_many :votes
  validates :username, uniqueness: true, length: { in: 5..20}
  
end
