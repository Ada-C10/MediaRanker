class User < ApplicationRecord
  has_many :votes
	has_many :works, through: :votes
	# has_many :works # optional

  validates :username, presence: true
end
