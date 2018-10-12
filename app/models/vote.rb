class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :work_id, presence: true, uniqueness: { scope: :user_id, message: "has already voted for this work" }
end
