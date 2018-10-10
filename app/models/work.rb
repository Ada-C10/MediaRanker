class Work < ApplicationRecord
  validates :title, presence: true, length: { in: 5..100 }
  validates :creator, presence: true, length: { in: 5..100 }
  validates :category, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true, length: { in: 5..100 }

  has_many :votes
  has_many :users, through: :votes
end
