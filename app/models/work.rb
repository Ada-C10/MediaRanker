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
    # Sorts works in alphabetical order
    return Work.where(category: category).order(title: :asc).to_a
  end

  def self.spotlight
    # Spotlight returns the work with the highest number of votes
    max_votes = Work.all.reduce(0) do |max, work|
      work.number_of_votes > max ? work.number_of_votes : max
    end
    # If none of the works have any votes, spotlight returns nil
    if max_votes < 1
      return nil
    else
    # Tiebreaking: Spotlight will show the most recently upvoted work
      spotlight = Work.all.select {|work| work.number_of_votes == max_votes}
      spotlight = spotlight.sort_by {|work| work.most_recent_vote}.reverse!
      return spotlight.first
    end
  end

  # Helper method for Spotlight
  def most_recent_vote
    most_recent_vote_date = self.votes.reduce(0) do |most_recent_vote_date, vote|
      vote.created_at > most_recent_vote_date ? vote.created_at : most_recent_vote_date
    end
    if most_recent_vote_date == 0
      return Date.jd(0)
    else
      return most_recent_vote_date
    end
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
