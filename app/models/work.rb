class Work < ApplicationRecord
  # before_save :calculate_vote_total
  # Many votes can be associated with a single work
  has_many :votes
  # has_many :users :through :votes

  WORKS = ['movie', 'album', 'book']

  validates :category, presence: true, inclusion: { in: WORKS }
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true
  validates :title, presence: true, uniqueness: true
  #
# Could be a class method - then might work 
  def top_ten_list(category)
    # Select all of category from work instances
    work_by_category = Work.all.select { |work| work.category.downcase == "#{category}" }
    # Return max by vote count for top 10
    return work_by_category.max_by(10) { |work| work.votes.length }
  end

  # def self.categories
  #   return (WORKS)
  # end

  # Method to sort by category/number of votes?
  # Handle if there are no works
  # If there's no votes (randomly, alphabetically?,)
  # Tie votes

end
