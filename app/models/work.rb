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
    top_ten = self.albums.sort_by { |work| work.votes.count }.reverse!
    return top_ten.first(10)
  end

  def self.top_ten_books
    top_ten = self.books.sort_by { |work| work.votes.count }.reverse!
    return top_ten.first(10)
  end

  def self.top_ten_movies
    top_ten = self.movies.sort_by { |work| work.votes.count }.reverse!
    return top_ten.first(10)
  end


end
