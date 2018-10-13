class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  CATEGORY = ["album", "book", "movie"]

  validates :title, presence: true
  validates :category, inclusion: { in: CATEGORY }
  validates_uniqueness_of :title, scope: :category

  def self.top_media(category)
    works = Work.all.where(category: category)
    top_works = works.sort_by { |w| w.votes.count }.reverse
    return top_works.first(10)
  end

  def self.spotlight
   return work = Work.all.max_by { |w| w.votes.count }
  end

  def self.get_all_works(category)
    works = Work.all.where(category: category)
    return works.sort_by { |w| w.votes.count }.reverse
  end


end
