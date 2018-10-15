class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all

  validates :title, presence: true, uniqueness: true
  validates :creator, :category, :description, :publication_year, presence: true

  def self.works_by_category(category)
    return Work.where(category: category)
  end

  def self.top_works_by_category(category)
    works = self.works_by_category(category)
    works = works.sort_by {|work| work.votes.count}.reverse!
   return works[0..9]
  end

  def self.top_work
    return Work.all.max_by {|work| work.votes.count}
  end

end
