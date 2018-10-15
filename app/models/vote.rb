
class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  validates :work_id, presence: true

  validate :one_vote_per_user, on: :create

  def one_vote_per_user
    user = User.find_by(id: user_id)
    works = user.votes.pluck(:work_id)
    result = works.find do |work|
      work == work_id
    end
    if result
      errors.add(:user_id, "can't vote on same work twice")
    end
  end

end
