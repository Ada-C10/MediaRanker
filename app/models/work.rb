class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }
end
