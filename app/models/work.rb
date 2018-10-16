class Work < ApplicationRecord
  # TODO: refactor with active record methods for sorting, filtering, and ordering!

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

  def self.sort(array_of_works)
    # 1. number of votes (descending)
    # 2. date of most recent vote (descending)
    # 3. title (ascending)
  # (No two works in the same category can have the same title)

    array_of_works.sort! { |work, next_work|
      [ next_work.number_of_votes,
        next_work.most_recent_vote_time,
        work.title
      ] <=>
      [ work.number_of_votes,
        work.most_recent_vote_time,
        next_work.title
      ]
    }
    return array_of_works
  end

# Returns a date for a single work
# Required for the self.sort method
  def most_recent_vote_time
    most_recent_vote_time = self.votes.reduce(0) do |most_recent_vote_time, vote|
      vote.created_at > most_recent_vote_time ? vote.created_at : most_recent_vote_time
    end

    if most_recent_vote_time == 0
      # If a work has no votes, then the date is set as Time.new(0), which is a very long time ago
      # This is a weird workaround for other methods that need to sort_by most_recent_vote_time
      # (Integer 0 cannot be compared with Time objects)
      most_recent_vote_time = Time.new(0)
    end

    return most_recent_vote_time
  end

# Used by list_top_works, #show, and #index in WorksController
  def self.list_all_works
   all_works = Hash.new
   VALID_WORK_CATEGORIES.each do |category|   # Find project constants in config/initializers/constants.rb
     works_by_category = Work.by_category(category)
     all_works[category] = Work.sort(works_by_category)
   end
   return all_works
  end

 # Helper method for #home in WorksController
 # Execute this method after self.list_all_works
  def self.top_ten(sorted_hash)
    top_ten_works = Hash.new
    sorted_hash.each do |category, works|
      unless works == []
        works = works[0..9]
        works.delete_if { |work| work.number_of_votes < 1 }
      end
      top_ten_works[category] = works
    end
    return top_ten_works
  end

# Execute this method after self.top_ten(sorted_hash)
def self.spotlight(sorted_hash)
  # If none of the works have any votes, spotlight returns nil
  if Vote.none?
    return nil
  else
    top_works = []
    sorted_hash.each do |category, works|
      unless works.first.nil?
        top_works << works.first
      end
    end
    return Work.sort(top_works).first
  end
end

# Required for list_all_works
  def self.by_category(category)
    return Work.where(category: category).order(title: :asc).to_a
  end

# TODO: write tests for this method
  def upvote_button
    if !@current_user
      return nil
    elsif self.has_no_vote_by?(@current_user)
      return "Upvote"
    else
      return "Remove Upvote"
    end
  end

# TODO: write tests for this method
  def vote_by_current_user
    if @current_user
      return self.votes.find_by(user_id: @current_user.id)
    else
      return nil
    end
  end

# TODO: write tests for this method
  def has_no_vote_by?(current_user)
    return self.votes.where(user: current_user).any?
  end

# TODO: write tests for this method
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
