class Work < ApplicationRecord
  has_many :votes, dependent: :nullify

  validates :title, presence: true, uniqueness: true, on: :create
  validates :creator, presence: true
  validates :category, presence: true
  validates :pub_year, numericality: {only_integer: true, less_than_or_equal_to: 2018}

  def self.spotlight
    most_voted = Work.first
    Work.all.each do |work|
      if work.votes.length > most_voted.votes.length
        most_voted = work
      end
    end
    return most_voted
  end

end
