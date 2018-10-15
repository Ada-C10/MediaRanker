class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true, length: { in: 5..100 }
  validates_inclusion_of :category, in: %w(book album movie)
  validates :publication_year, presence: true
  validates :description, presence: true, length: { in: 5..100 }

  has_many :votes
  has_many :users, through: :votes

  def self.albums
    where(category: 'album')
  end

  def self.books
    where(category: 'book')
  end

  def self.movies
    where(category: 'movie')
  end

  def self.work_with_max_votes
    max_work = work

    return max_work
  end

  def self.top_albums
    top_albums = []

    return top_albums
  end

  def self.top_books
    top_albums = []

    return top_books
  end

  def self.top_movies
    top_albums = []

    return top_movies
  end

  def upvote(user)
    Vote.create(user: user, work: self)
  end

end
