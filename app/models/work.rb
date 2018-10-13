class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  # def find_work_id
  #   return self.id
  # end

  # self.votes is returning the votes for the specific work
  # the 'has_many :votes' is doing the work of finding votes whose work_id is equal to the work that is being passed in
  def total_votes
    num_of_votes = self.votes.count
    return num_of_votes
  end

  def users_that_voted_on_this_work
    # work_id = find_work_id
    # array_of_votes = Vote.find_by(work_id: work_id)
    array_of_votes = self.votes
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

  def find_vote_where_work_upvoted_by_user(user_id)
    # vote = Vote.find_by(user_id: user_id, work_id: work_id)
    vote = Vote.find_by(user_id: user_id, work_id: self.id)

    return vote
  end
end
