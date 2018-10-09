class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true

  def self.movies_list
    return Work.select { |work| work.category == 'movie' }
  end

  def self.books_list
    return Work.select { |work| work.category == 'book' }
  end

  def self.albums_list
    return Work.select { |work| work.category == 'album' }
  end

end
