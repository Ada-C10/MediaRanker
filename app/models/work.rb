class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: { scope: :category }
  #validates :publication_year, length: { is: 4}
  validates :category, inclusion: { in: %w(movie album book),
    message: "%{value} is not a valid size" }


  def self.category(media)
      return Work.all.order(:title).select {|work| work.category == media}
  end

  def self.spotlight
    return Work.all.max_by { |work| work.votes.length }
  end

  def self.top_albums
    return Work.category('album').max_by(10) { |work| work.votes.length }
  end

  def self.top_movies
    return Work.category('movie').max_by(10) { |work| work.votes.length }
  end

  def self.top_books
    return Work.category('book').max_by(10) { |work| work.votes.length }
  end


end
