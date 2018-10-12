class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  def find_work_id
    return self.id
  end

  def votes_for_this_work
    work_id = find_work_id
    array_of_votes = Vote.where(work_id: work_id)
    return array_of_votes
  end

  def total_votes
    num_of_votes = votes_for_this_work.count
    return num_of_votes
  end

  def users_that_voted_on_this_work
    work_id = find_work_id
    array_of_votes = Vote.where(work_id: work_id)
    users_ids = []

    array_of_votes.each do |vote|
      users_ids << vote.user_id
    end

    array_of_users = []
    users_ids.each do |x|
      user = User.find_by(id: x)
      array_of_users << user
    end

    return array_of_users
  end

  def date_work_upvoted_by_user(work, user_id)
    work_id = work.id
    vote = Vote.where(user_id: user_id, work_id: work_id)

    return vote
  end
end
