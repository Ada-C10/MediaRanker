class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  has_many :votes
end
