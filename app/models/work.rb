class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true, length: { in: 5..100 }
  validates_inclusion_of :category, in: %w(book album movie)
  validates :publication_year, presence: true
  validates :description, presence: true, length: { in: 5..100 }

  has_many :votes
  has_many :users, through: :votes

  def self.albums
    where(category: 'album')
  end

  def self.books
    where(category: 'book')
  end

  def self.movies
    where(category: 'movie')
  end

  def self.highest_rated
    left_outer_joins(:votes)
      .group("works.id")
      .order(Arel.sql("count(votes.id) DESC"))
  end

  def upvote(user)
    #Vote.create(user: user, work: self)
    votes.create(user: user)
  end

end
