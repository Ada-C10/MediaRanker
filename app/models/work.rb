class Work < ApplicationRecord
  has_many :user, through: :votes

  validates :title, uniqueness: true, length: { in: 5..25 }
  # validates :publication_year, length: { is: 4 }
end
