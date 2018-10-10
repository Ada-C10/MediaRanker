class Work < ApplicationRecord
  has_many :votes
  has_many :user, through: :votes

  validates :title, presence: true, uniqueness: true, length: { in: 4..40 }
  validates :creator, presence: true
  validates :publication_year, numericality: { greater_than: 999, less_than: 10000 }
  validates :description, presence: true
end
