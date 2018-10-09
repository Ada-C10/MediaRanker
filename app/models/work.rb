class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true

  CATEGORY = ["book", "album", "movie"]
end
