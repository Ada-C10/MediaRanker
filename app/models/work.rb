class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, uniqueness: true, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  validates :category, presence: true

  def self.albums

  end

  def self.books
  end

  def self.movies
  end
end
