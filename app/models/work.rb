class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: true
  validates :created_by, presence: true
  validates :category, presence: true

  # def top_movies
  #   return @movies.sort_by {|movie| movie.votes}
  #   # binding.pry
  # end
  #
  # def top_books
  #   return @books.sort_by {|book| book.votes}
  # end
  #
  # def top_albums
  #   return @albums.sort_by {|album| album.votes}
  # end

  # def top_works
  #   @works.sort_by {|work| work.votes}
  #   return @works
  # end

  def tally_votes
    num_votes = self.votes.count
      return num_votes
  end
end
