class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true

  CATEGORY = ["Book", "Album", "Movie"]
end
