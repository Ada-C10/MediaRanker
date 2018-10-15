class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true


  def self.total_votes
    self.left_outer_joins(:votes).group(:id).order(Arel.sql('COUNT(votes.id) DESC'))
  end


  def self.ranked_media(category)
    all_media = self.where(category: category)
    votes_by_work = all_media.total_votes
  end


  def self.top_ten(category)
    top_ten = self.ranked_media(category)
    top_ten.first(10)
  end


  def self.top_media
    total_votes = self.total_votes
    top_media = total_votes.first
  end


  def see_voters

    voters = []

    self.votes.each do |vote|
      user = User.find_by(id: vote.user_id)

      voters << user
    end

    return voters

  end

end
