class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true, uniqueness: true
  validates :publication_year, presence: true, length: { is: 4 }
end
