class Work < ApplicationRecord
  # relationships

  # validation
  validates :creator, :publication_year, :title, :category, presence: true
  validates :title, length: { in: 1..200 }
  validates :title, uniqueness: true

end
