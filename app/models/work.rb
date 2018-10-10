class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
	# belongs_to :user # optional

  validates :category, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }

  def self.spotlight
    return Work.all.max_by { |work| work.votes.length }
  end

  def self.list_of(work_category)
    return sort_by_votes(Work.all.select { |work| work.category == work_category })
  end

  private

    def self.sort_by_votes(work_list)
      return work_list.sort_by { |work| -work.votes.length }
    end
end
