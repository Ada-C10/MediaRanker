class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 40 }
  validates :category, presence: true, inclusion: { in: VALID_CATEGORIES,
    message: "%{value} is not a valid category" }
  validates :creator, presence: true, length: { maximum: 30 }
  validates :publication, presence: true, numericality: { only_integer: true, less_than_or_equal_to: Date.today.year }
  validates :description, length: { maximum: 50 }
end
