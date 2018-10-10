class Work < ApplicationRecord
  validates :title, presence: true
  validates :creator, presence: true, uniqueness: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 0,  less_than: 2019}
  validates :category, presence: true
end
