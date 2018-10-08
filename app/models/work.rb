class Work < ApplicationRecord
  has_many :votes

  validates :title, :description, :creator, :category, presence: true
  validates :published, numericality: true
end
