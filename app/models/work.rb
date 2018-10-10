class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true
  validates_uniqueness_of :title, scope: :category

  CATEGORY = ["book", "album", "movie"]
end
