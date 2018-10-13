class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  CATEGORIES = %w(movie book album)

  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true, :numericality => {:less_than => Date.today.year, :greater_than => 1700}
  validates :description, presence: true
  validates :category, inclusion: { in: CATEGORIES }

  def top_movies
    movies = []
    @works.each do |work|
      if work.category == "movie"
        movies << work
      end
    end
    movies.sort_by do |movie|
      -movie.votes.count
    end
    return movies
  end

  def top_books
    books = []
    @works.each do |work|
      if work.category == "book"
        books << work
      end
    end
    movies.sort_by do |movie|
      -books.votes.count
    end
    return books
  end
end
