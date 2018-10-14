class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :user_id, presence: true
  validates :work_id, presence: true
  validates :work, uniqueness: {
    scope: :user, message: "user: has already voted for this work" }

private

    def self.find_votes_by_user(given_user_id)
      return self.where(user_id: given_user_id)
    end

    def self.find_votes_by_work(given_user_id)
      return self.where(user_id: given_user_id)
    end
end
