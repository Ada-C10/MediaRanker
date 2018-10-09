class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: {
    scope: :category, message: "A category can't have repeat name"
  }

  validates :category, presence: true


end
