class Work < ApplicationRecord
  has_many :votes
  # has_many :users, through :votes

  validates :title, presence: true, uniqueness: {scope: :category}
  validates :publication_year, numericality: true, length: {is: 4}
  validates :creator, presence: true
CATEGORIES = ['movie', 'album', 'book']

  def self.sort_by_category(category)
    selected_works = []
    @works = Work.all
    @works.each do |work|
      if category == work.category
        selected_works << work
      end
    end
    return selected_works
  end

  def self.sort_by_votes(category)
    @works = self.sort_by_category(category)
    return top_10 = @works.sort_by{|work| work.votes.count}.reverse!
  end




end
