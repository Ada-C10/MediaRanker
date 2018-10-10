class Work < ApplicationRecord
  has_many :vote

  validates :title, :creator, :category, :description, :publication_year, presence: true
end
