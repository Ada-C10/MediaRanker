class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  def upvote(work_id)
    @vote = Vote.new(work_id)
    @vote.save
  end
end
