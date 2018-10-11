class Work < ApplicationRecord
  has_many :votes

  CATEGORY = ["album", "book", "movie"]

  validates :title, presence: true
  validates :category, inclusion: { in: CATEGORY }
  validates_uniqueness_of :title, scope: :category

end
