class Work < ApplicationRecord
  has_many :user, through: :votes
end
