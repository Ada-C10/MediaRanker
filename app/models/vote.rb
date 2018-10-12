class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true, uniqueness: { scope: :work, message: "You can only add one vote per work"}
  # validates :work_id, presence: true
end
