class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
	# belongs_to :user # optional

  validates :category, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }

  def self.spotlight
    return Work.all.max_by { |work| work.votes.length }
  end

  def self.albums
    return sort_by_votes(Work.all.select { |work| work.category == "album" })
  end

  def self.books
    return sort_by_votes(Work.all.select { |work| work.category == "book" })
  end

  def self.movies
    return sort_by_votes(Work.all.select { |work| work.category == "movie" })
  end

  private

    def self.sort_by_votes(work_list)
      return work_list.sort_by { |work| -work.votes.length }
    end
end
