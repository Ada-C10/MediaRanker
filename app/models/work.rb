class Work < ApplicationRecord
  has_many :votes
  has_many :user, through: :votes

  validates :title, uniqueness: true, length: { in: 5..25 }
  validates :publication_year, numericality: { greater_than: 999, less_than: 10000 }
end
