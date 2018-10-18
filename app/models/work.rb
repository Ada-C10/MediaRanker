class Work < ApplicationRecord
belongs_to :user

has_many :votes, dependent: :destroy


validates :category, presence: true
validates :title, presence: true
validates :creator, presence: true
validates :publication_year, presence: true
validates :description, presence: true

def self.best_albums
  top_ten("album")
end

def self.best_books
  top_ten("book")
end

def self.best_movies
  top_ten("movie")
end

def self.top_ten(category)
  where(category: category).order(vote_count: :desc).limit(10)
end


end
