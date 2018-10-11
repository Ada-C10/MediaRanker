class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  def find_work_id
    return self.id
  end

  def total_votes
    work_id = find_work_id

    array_of_votes = Vote.where(work_id: work_id)
    num_of_votes = array_of_votes.count

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
end
