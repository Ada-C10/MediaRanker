class Work < ApplicationRecord

  WORK_CATEGORIES = %w(album movie book)

  has_many :votes
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: WORK_CATEGORIES}
end
