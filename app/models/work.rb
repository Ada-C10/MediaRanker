class Work < ApplicationRecord
  # Many votes can be associated with a single work
  has_many :votes
  # has_many :users :through :votes

  WORKS = ['movie', 'album', 'book']

  validates :category, presence: true, inclusion: { in: WORKS }
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true
  validates :title, presence: true, uniqueness: true

  def self.top_movie_list
    movies = Work.all.select { |work| work.category.downcase == "movie" }
    #returns a array 
    @votes_per_movie_count = Vote.joins(:work).group(:work).order('count_all DESC').limit(10).count
  end

  # Can do work.votes for an array of all votes associated with the work
  # Can push votes via work.votes << vote_object
  # work.votes.where(conditions) to get votes for the work with the condition
  # Method to upvote a work. Will need to make sure user/work is unique
  # User can only vote once per work

  # Method to sort by category
  # Handle if there are no works
  # If there's no votes (randomly, alphabetically?,)
  # Tie votes

end
