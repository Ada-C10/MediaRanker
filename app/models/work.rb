class Work < ApplicationRecord
  include Enumerable
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, numericality: { only_integer: true }
  has_many :votes
  has_many :upvoted_users, through: :votes, source: :user

  def self.sort_by_votes
    return self.all.sort_by { |work| work.votes.count }.reverse
  end

  def self.spotlight
    return Work.sort_by_votes.first
  end
end
