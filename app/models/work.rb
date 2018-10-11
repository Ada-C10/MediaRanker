class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: %w(album movie book) }
  validates :publication_year, numericality: { only_integer: true } 
end
