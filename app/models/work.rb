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
      spotlight = Work.sort_by_most_recent_vote(spotlight).reverse!
      return spotlight.first
    end
  end

  def self.sort_by_most_recent_vote(array_of_works)
    return array_of_works.sort_by{|work| work.most_recent_vote_date}
  end

# Returns a date for a single work
  def most_recent_vote_date
    most_recent_vote_date = self.votes.reduce(0) do |most_recent_vote_date, vote|
      vote.created_at > most_recent_vote_date ? vote.created_at : most_recent_vote_date
    end

    if most_recent_vote_date == 0
      # If a work has no votes, then the date is set as Date.jd(0), which is a very long time ago
      # This is a weird workaround for other methods that need to sort_by most_recent_vote
      # (Integer 0 cannot be compared with Date objects)
      most_recent_vote_date = Date.jd(0)
    end

    return most_recent_vote_date
  end

# Helper for list_top_works and #index in WorksController
 def self.list_all_works
   all_works = Hash.new
   VALID_WORK_CATEGORIES.each do |category|   # Find project constants in config/initializers/constants.rb
     works_by_category = Work.by_category(category).reverse # Z to A
     works_by_category = Work.sort_by_most_recent_vote(works_by_category)  #oldest to newest
     all_works[category] = works_by_category.sort_by { |work| work.number_of_votes }.reverse!
                                                     # fewest to most          # then reverse it
       # after .reverse!, the final sort order is:
       # 1. most to fewest votes,
       # 2. newest to oldest vote,
       # 3. A to Z (by title)
   end
   return all_works
 end

 # Helper method for #home in WorksController
   def self.list_top_works
    top_ten_works = Work.list_all_works

    top_ten_works.each_key do |category|
      # Do not display works with 0 votes
      top_ten_works[category] = top_ten_works[category].delete_if { |work| work.number_of_votes < 1 }

      # Display only the top 10 works
      top_ten_works[category] = top_ten_works[category][0..9]
    end
    return top_ten_works
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
