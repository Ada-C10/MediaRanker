class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  has_and_belongs_to_many :categories

  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :year, presence: true
  validates :description, presence: true
  validates :category, presence: true

end
