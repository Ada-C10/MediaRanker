class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :created_by, presence: true
  validates :category, presence: true
  
end
