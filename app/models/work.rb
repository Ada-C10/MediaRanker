class Work < ApplicationRecord
  validates :title, presence: true

  def self.albums
    return Work.where(category: 'album')
  end

  def self.books
    return Work.where(category: 'book')
  end

  def self.movies
    return Work.where(category: 'movie')
  end

#make sure it returns an instance of Array
#make sure each category inside is
end
