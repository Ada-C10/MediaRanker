class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :votes

  def self.categories
    return %w(album book movie)
  end
end
