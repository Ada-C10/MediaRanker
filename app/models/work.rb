class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true


  def self.total_votes
    self.left_outer_joins(:votes).group("works.title").count("votes")
  end


  def self.ranked_media(category)
    all_media = self.where(category: category)
    votes_by_work = all_media.total_votes
    votes_by_work = votes_by_work.sort_by { |title, vote| -vote }
  end


  def self.top_ten(category)
    top_ten = self.ranked_media(category)
    top_ten.first(10)
  end


  def self.top_media
    total_votes = self.total_votes
    total_votes = total_votes.sort_by { |title, vote| -vote}
    top_media = total_votes.first
    media = self.find_by(title: top_media[0])
  end


end
