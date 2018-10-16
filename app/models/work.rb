class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true

  def self.sort_works(category)
    works = Work.where(category: category)
    sorted_works = works.sort_by {|work| work.votes.count}
    return sorted_works.reverse
  end

  def self.list_top_ten(category)
    works = Work.sort_works(category)
    return works[0..9]
  end

  def self.find_top_work
    works = Work.all
    work = works.sort_by {|work| work.votes.count}
    return work[-1]
  end
end
