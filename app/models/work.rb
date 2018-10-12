class Work < ApplicationRecord
  # relationships
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  # validation
  CATS = %w(album movie book)
  validates :creator, :publication_year, :title, :category, presence: true
  validates :title, length: { in: 1..200 }
  validates :title, uniqueness: true
  validates :category, inclusion: { in: CATS }
  # pub year must be number in year range 0 - 2018
  validates :publication_year, numericality: true, inclusion: 0..2018

  def self.top?(category)
    # works = self.where(category: category)
    # top_works = works.order(votes.count)
    # works = Work.joins(:votes).group("votes.work_id").order("count(votes.work_id) desc")

    # works = SELECT "works".* FROM "works" LEFT OUTER JOIN "votes" ON "votes"."work_id" = "works"."id" GROUP BY "work"."id" ORDER BY COUNT(votes.id)DESC
    works = Vote.group(:work_id).select('SUM(votes) as tot').order('tot desc')
    Work.select("date(created_at) as ordered_date, sum(price) as total_price").group("date(created_at)")
    top_works = works.first(10)
    return top_works
  end

  def self.spotlight?
    
    spot = self.all.sample
   
    return spot
  end

end

