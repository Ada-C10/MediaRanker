class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :title, uniqueness: true, length: { in: 3..100}
  validates :category, presence: true

  validates_inclusion_of :category, :in => ['book', 'album','movie']

  def self.book_list
     return Work.all.select {|work| work.category == "book"}.sort_by {|e| e.votes.count}.reverse

  end

  def self.album_list
     return Work.all.select {|work| work.category == "album"}.sort_by {|e| e.votes.count}.reverse
  end

  def self.movie_list
     return Work.all.select {|work| work.category == "movie"}.sort_by {|e| e.votes.count}.reverse
  end
end
