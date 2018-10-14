class Work < ApplicationRecord
  has_many :votes

  validates :title, :creator, :category, :description, :publication_year, presence: true

  def self.works_by_category(category)
    return Work.where(category: category)
  end

  def self.top_works_by_category(category)
    works = self.works_by_category(category)
    works = works.sort_by {|work| work.votes.count}.reverse!
   return works[0..9]
  end

end
