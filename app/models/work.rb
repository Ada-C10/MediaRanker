class Work < ApplicationRecord
  validates :title, presence: true
  validates_inclusion_of :category, in: %w(book album movie)
  has_many :users, through :votes 
  has_many :votes


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
