class Work < ApplicationRecord
  # Many votes can be associated with a single work
  has_many :votes
  # has_many :users :through :votes

  WORKS = ['movie', 'album', 'book']

  validates :category, presence: true, inclusion: { in: WORKS }
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true
  validates :title, presence: true, uniqueness: true

  def self.top_ten_list(category)
    # Select all of category
    work_by_category = Work.all.select { |work| work.category.downcase == "#{category}" }
    # Return max by vote count for top 10
    return work_by_category.max_by(10) { |work| work.votes.length }
  end

  def self.categories
    return (WORKS)
  end

  # Sort method - Apply to works index pagew 
  def self.sort_by_vote


  end

  # find top work for media Spotlight


  # Method to sort by category
  # Handle if there are no works
  # If there's no votes (randomly, alphabetically?,)
  # Tie votes

end
