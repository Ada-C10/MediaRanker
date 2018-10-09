class Work < ApplicationRecord
  validates :title, presence: true

  def self.albums
    return Work.find_by(category: 'album')
  end

  def self.books
    return Work.find_by(category: 'book')
  end

  def self.movies
    return Work.find_by(category: 'movie')
  end
end
