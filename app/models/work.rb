class Work < ApplicationRecord
  has_many :votes

  validates :title, uniqueness: true, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  validates :category, presence: true

end
