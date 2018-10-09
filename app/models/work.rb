class Work < ApplicationRecord
  validates :title, presence: true
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
