class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: { scope: :category, case_sensitive: false },
    length: { maximum: 40 }
  validates :category, presence: true, inclusion: { in: VALID_WORK_CATEGORIES,
    message: "%{value} is not a valid category" }
  validates :creator, presence: true, length: { maximum: 30 }
  validates :publication, presence: true, numericality: { only_integer: true,
    less_than_or_equal_to: Date.today.year, greater_than_or_equal_to: 1000 }
  validates :description, length: { maximum: 140 }

  def self.by_category(category)
    works = Work.where(category: category).order(title: :desc)
    return works.sort_by { |work| work.number_of_votes }.reverse!
  end

  def self.spotlight
    spotlight = Work.all.max_by {|work| work.number_of_votes}
    if spotlight.number_of_votes < 1
      return nil
    else
      return spotlight
    end
    # tie breaking?
  end

  def upvote_button
    if !@current_user
      return nil
    elsif self.has_no_vote_by?(@current_user)
      return "Upvote"
    else
      return "Remove Upvote"
    end
  end

  def vote_by_current_user
    if @current_user
      return self.votes.find_by(user_id: @current_user.id)
    else
      return nil
    end
  end

  def has_no_vote_by?(current_user)
    return !self.votes.any? { |vote| vote.user == current_user }
  end

  def number_of_votes
    return self.votes.size
  end

  def print_number_of_votes
    if self.votes.size != 1
      return "#{self.votes.size} votes"
    else
      return "#{self.votes.size} vote"
    end
  end
end
