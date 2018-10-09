class Work < ApplicationRecord
  has_many :votes

  validates :title, uniqueness: true, length: {in: 5..25}
  validates :publication_year, numericality: true, length: {is: 4}
  validates :creator, presence: true

end
