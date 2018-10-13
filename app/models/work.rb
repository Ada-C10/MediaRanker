class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: { scope: :category, case_sensitive: false },
    length: { maximum: 40 }
  validates :category, presence: true, inclusion: { in: VALID_WORK_CATEGORIES,
    message: "%{value} is not a valid category" }
  validates :creator, presence: true, length: { maximum: 30 }
  validates :publication, presence: true, numericality: { only_integer: true,
    less_than_or_equal_to: Date.today.year, greater_than_or_equal_to: 1700 }
  validates :description, length: { maximum: 50 }

  def self.by_category(category)
    return Work.where(category: category).order(:title)
  end

  def self.spotlight
    return Work.all.max_by {|work| work.number_of_votes}
    # tie breaking?
  end

  def has_no_vote_by?(current_user)
    raise ArgumentError if current_user == false
    return !self.votes.any? { |vote| vote.user == current_user }
  end

  def number_of_votes
    return self.votes.size
  end
end
