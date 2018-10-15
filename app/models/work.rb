class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: %w(album movie book) }
  validates :publication_year, numericality: { only_integer: true }
  scope :ordering, -> {order('votes_count DESC')}

  CATEGORIES = %w[album book movie]

  def self.get_categories
    return CATEGORIES
  end
end
