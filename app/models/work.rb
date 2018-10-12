class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, uniqueness: true, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  validates :category, presence: true

  def self.top_albums
    albums = Work.where(category: "album")
    sorted_albums = albums.sort_by { |album| album.votes.count }
    descending_albums = sorted_albums.reverse
    return descending_albums[0..9]
  end

  def self.top_books
    books = Work.where(category: "book")
    sorted_books = books.sort_by { |book| book.votes.count }
    descending_books = sorted_books.reverse
    return descending_books[0..9]
  end

  def self.top_movies
    movies = Work.where(category: "movie")
    sorted_movies = movies.sort_by { |movie| movie.votes.count }
    descending_movies = sorted_movies.reverse
    return descending_movies[0..9]
  end

  def self.top_work
    works = Work.all
    sorted_works = works.sort_by { |work| work.votes.count }
    return sorted_works.last
  end
end
