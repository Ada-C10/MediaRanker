require 'pry'
class Work < ApplicationRecord
  has_many :votes
	# belongs_to :user # optional

  validates :category, presence: true
  validates :title, presence: true

  # validates :title, uniqueness: true
  # only needs to be unique for the category

  def self.spotlight
    return Work.all.max_by { |work| work.votes.length }
  end

  def self.albums
    return Work.all.select { |work| work.category == "album" }
  end

  def self.books
    return Work.all.select { |work| work.category == "book" }
  end

  def self.movies
    return Work.all.select { |work| work.category == "movie" }
  end
end
