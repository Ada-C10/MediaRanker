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


end
