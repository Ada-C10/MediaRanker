class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: {scope: :category}
  validates :publication_year, numericality: true, length: {is: 4}
  validates :creator, presence: true



end
