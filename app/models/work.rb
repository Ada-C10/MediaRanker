class Work < ApplicationRecord
  has_many :votes
  # has_many :user, through: :votes

  validates :title, :description, :creator, :category, presence: true
  validates :published, numericality: true

  def self.get_books
    books = Work.all.where(category: "book")
    books.sort_by {|book| book.votes.count}.reverse!
  end

  def self.get_albums
    albums = Work.all.where(category: "album")
    albums.sort_by {|album| album.votes.count}.reverse!
  end

  def self.get_movies
    movies = Work.all.where(category: "movie")
    movies.sort_by {|movie| movie.votes.count}.reverse!
  end


end
