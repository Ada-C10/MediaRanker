class Work < ApplicationRecord
  has_many :votes
  CATEGORIES = %w(album book movie)
  validates :title, presence: true
  validates :creator, presence: true, uniqueness: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 1000,  less_than: 2019}
  validates :category, presence: true, inclusion: { in: CATEGORIES}
end
