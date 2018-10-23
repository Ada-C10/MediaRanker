class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :work_id, :user_id, :vote_time, presence: true
end
