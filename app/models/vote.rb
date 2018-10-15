class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :work_id,
    message: "can only vote for a work once" }
end
