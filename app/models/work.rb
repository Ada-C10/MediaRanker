class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }

  def self.by_category(media_type)
    list = self.left_joins(:votes).select("works.*, COUNT(votes) as vote_count").group("works.id").where(category: media_type).order("vote_count DESC")

    return list
  end

  def destroy_votes
    votes = Vote.all.where(work_id: self.id)
    votes.each { |vote| vote.destroy }
  end
end
