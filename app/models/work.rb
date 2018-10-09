class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  vaildates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true
  
end
