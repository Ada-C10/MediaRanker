class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :votes, dependent: :nullify

  def self.categories
    return %w(album book movie)
  end

  def self.sort_by_votes(category)
    unless self.categories.include?(category)
      raise ArgumentError, "#{category} is not a valid category."
    end

    works = Work.where(category: category)
    return works.sort_by{ |work| -work.votes.length }
  end

end
