class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :year, presence: true
  validates :description, presence: true
  validates :category, presence: true

end
