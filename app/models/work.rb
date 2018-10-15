class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :category, message: "can only occur once per category" }
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 0,  less_than: 2019}
  validates :description, presence: true, length: { in: 5..250 }
  CATEGORIES = %w(album book movie)
  validates :category, presence: true, inclusion: { in: CATEGORIES}

  def self.category_list(category)
    return Work.where(category: category).sort_by {|work| work.votes.count}.reverse!
  end
  
  def self.top_work
    return Work.all.sort_by {|work| work.votes.count}.reverse.first
  end

  def self.top_category_list(category)
    top_categories =  Work.category_list(category)
    return top_categories if top_categories.length < 10
    return top_categories[0..9]
  end

end
