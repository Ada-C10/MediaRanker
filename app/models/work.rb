class Work < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }
  validates_inclusion_of :category, in: %w(book album movie)
  has_many :users, through: :votes
  has_many :votes

  def self.albums
    return Work.where(category: 'album').order(Arel.sql('votes_count IS NULL, votes_count DESC'), title: :asc)
  end

  def self.books
    return Work.where(category: 'book').order(Arel.sql('votes_count IS NULL, votes_count DESC'), title: :asc)
  end

  def self.movies
    return Work.where(category: 'movie').order(Arel.sql('votes_count IS NULL, votes_count DESC'), title: :asc)
  end

end
