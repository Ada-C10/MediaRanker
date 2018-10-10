class Work < ApplicationRecord
  has_many :votes

  validates :title, :creator, :category, :description, :publication_year, presence: true
end
