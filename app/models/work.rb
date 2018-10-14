class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  CATEGORIES = %w(movie book album)

  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true, :numericality => {:less_than => Date.today.year, :greater_than => 1700}
  validates :description, presence: true
  validates :category, inclusion: { in: CATEGORIES }

  def self.show_by_vote(category)
    Work.all.sort_by { |work| -work.votes.count }.select { |work| work.category == category}
  end

  def self.top_vote
    Work.all.sort_by { |work| -work.votes.count }.first
  end
end
