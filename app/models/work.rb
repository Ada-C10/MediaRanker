class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  validates :title, presence: true, uniqueness: {scope: :category, message: "This already in this category!"}
  validates :publication_year, presence: true, inclusion: { in: 1000..Date.today.year, message: "should be a four-digit year"}

  def self.albums
    return Work.select {|work| work.category == "album"}
  end

  def self.books
    return Work.select {|work| work.category == "book"}
  end

  def self.movies
    return Work.select {|work| work.category == "movie"}

  end
end
