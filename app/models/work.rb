class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  validates :title, presence: true, uniqueness: {scope: :category, message: "This already in this category!"}
  validates :publication_year, presence: true, inclusion: { in: 1000..Date.today.year, message: "should be a four-digit year"}

  def self.albums
    albums =  Work.select {|work| work.category == "album"}
    sorted_albums =  albums.sort_by{|work| work.votes.length}
    return sorted_albums.reverse

  end

  def self.books
    books =  Work.select {|work| work.category == "book"}
    sorted_books =  books.sort_by{|work| work.votes.length}
    return sorted_books.reverse

  end

  def self.movies
    movies =  Work.select {|work| work.category == "movie"}
    sorted_movies =  movies.sort_by{|work| work.votes.length}
    return sorted_movies.reverse


  end

end
