class Work < ApplicationRecord
  has_many :votes, dependent: :nullify

  validates :title, presence: true, uniqueness: true, on: :create
  validates :creator, presence: true
  validates :category, presence: true
  validates :pub_year, numericality: {only_integer: true, less_than_or_equal_to: 2018}

  def self.spotlight
    w = Work.all.sort_by {|work| work.votes.length }
    return w.reverse!.first
  end

  def self.sorted
    w = Work.all.sort_by {|work| work.votes.length }
    return w.reverse!
  end
end
