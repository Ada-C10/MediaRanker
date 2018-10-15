class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  has_and_belongs_to_many :categories

  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :year, presence: true, numericality: { only_integer: true }
  validates :description, presence: true
  validates :category, presence: true

def self.top_list
    all_works = Work.all.map do |work|
      [work.votes.count, work.title, work.category]
    end
    all_works.sort.reverse
end

end
