class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, uniqueness: true, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  validates :category, presence: true

  def self.top_ten(category)
    works = Work.where(category: category)
    sorted_works = works.sort_by { |work| work.votes.count }
    descending_works = sorted_works.reverse
    return descending_works[0..9]
  end

  def self.top_work
    works = Work.all
    sorted_works = works.sort_by { |work| work.votes.count }
    return sorted_works.last
  end
end
