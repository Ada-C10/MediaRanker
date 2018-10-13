class User < ApplicationRecord
  # self note: the dependent: :delete_all allows for a work to be deleted even though a user and a work are connected using foreign keys in the votes table
  has_many :votes, dependent: :delete_all

  validates :username, presence: true, uniqueness: true

  def vote(input_work_id)
    vote = Vote.where(user_id: self.id, work_id: input_work_id)
    # vote = Vote.find_by(user_id: self.id, work_id: input_work_id)
    return vote
  end

  def array_of_votes
    votes = Vote.where(user_id: self.id)
    return votes
  end

  def works_upvoted_ids
    upvotes = array_of_votes
    works_ids = []

    upvotes.each do |upvote|
      works_ids << upvote.work_id
    end

    return works_ids
  end

  def works_voted_on
    works_ids = works_upvoted_ids
    works = []

    works_ids.each do |work_id|
      work = Work.find_by(id: work_id)
      works << work
    end

    return works
  end
end
