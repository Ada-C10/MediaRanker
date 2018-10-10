class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }

  def destroy_votes
    votes = Vote.all.where(work_id: self.id)
    votes.each { |vote| vote.destroy }
  end
end
