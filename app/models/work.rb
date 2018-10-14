class Work < ApplicationRecord
  has_many :votes
  has_many :user, through: :votes

  validates :title, presence: true, uniqueness: true, length: { in: 4..40 }
  validates :creator, presence: true
  validates :publication_year, numericality: { greater_than: 999, less_than: 10000 }
  validates :description, presence: true


  def upvote(arg)
    if arg[:user_id].present?
      vote = Vote.new(work_id: self.id, user_id: arg[:user_id])
      self.votes << vote
      vote.save
    else
      raise ArugmentError, "User Id doesnt exsist"
    end
  end

  def self.list_by_votes(category)
    Work.all.sort_by {|work| -work.votes.count}.select { |work| work.category == category }
  end

  def self.spotlight
    Work.all.sort_by {|work| -work.votes.count}
  end


end
