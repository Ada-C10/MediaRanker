class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true


  def self.all_media(category)
    self.where(category: category)
  end


  def self.total_votes
    self.left_outer_joins(:votes).group("works.title").count("votes")
  end


  def self.ranked_media(category)

    all_media = self.all_media(category)

    votes_by_work = all_media.total_votes

    votes_by_work = votes_by_work.sort_by { |title, vote| -vote }

  end


end
