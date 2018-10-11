class Work < ApplicationRecord
  has_many :votes

  CATEGORIES = %w(movie book album)

  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true
  validates :category, inclusion: { in: CATEGORIES }
end
