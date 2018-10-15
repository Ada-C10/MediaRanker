class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  has_and_belongs_to_many :categories

  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :year, presence: true, numericality: { only_integer: true }
  validates :description, presence: true
  # validates :category

  # scope :by_votes, joins: :votes, group: "works.id", :order => "COUNT(works.id) DESC"

end
