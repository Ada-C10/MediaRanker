class Work < ApplicationRecord
  # relationships
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  # validation
  CATS = %w(album movie book)
  validates :creator, :publication_year, :title, :category, presence: true
  validates :title, length: { in: 1..200 }
  validates :title, uniqueness: true
  validates :category, inclusion: { in: CATS }
  # pub year must be number in year range 0 - 2018
  validates :publication_year, numericality: true, inclusion: 0..2018

end

