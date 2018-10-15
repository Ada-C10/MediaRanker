class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :user_id, presence: true
  validates :work_id, presence: true
  validates :work, uniqueness: {
    scope: :user, message: "user: has already voted for this work" }
end
