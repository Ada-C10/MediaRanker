class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true, length: { in: 5..100 }
  validates_inclusion_of :category, in: %w(book album movie)
  validates :publication_year, presence: true
  validates :description, presence: true, length: { in: 5..100 }

  has_many :votes
  has_many :users, through: :votes

  def self.albums
    return Work.where(category: 'album')
  end

  def self.books
    return Work.where(category: 'book')
  end

  def self.movies
    return Work.where(category: 'movie')
  end
end
