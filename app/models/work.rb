class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true, uniqueness: { scope: [:category] }
  validates :publication_year, inclusion: { in: 1000..Date.today.year, message: "should be a four-digit year"}, allow_blank: true
  validates :category, inclusion: { in: ['book', 'album', 'movie'], message: "should be a book, movie, or album"}

  def self.albums
    return Work.select {|work| work.category == 'album'}
  end

  def self.books
    return Work.select {|work| work.category == 'book'}
  end

  def self.movies
    return Work.select {|work| work.category == 'movie'}
  end

  def self.top_ten_albums
    return self.top_albums.first(10)
  end

  def self.top_ten_books
    return self.top_books.first(10)
  end

  def self.top_ten_movies
    return self.top_movies.first(10)
  end

  def self.top_albums
    return self.albums.sort_by { |work| work.votes.count }.reverse!
  end

  def self.top_books
    return self.books.sort_by { |work| work.votes.count }.reverse!
  end

  def self.top_movies
    return self.movies.sort_by { |work| work.votes.count }.reverse!
  end


end
