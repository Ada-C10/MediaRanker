class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :user_id, presence: true
  validates :work_id, presence: true
  validates :work, uniqueness: {
    scope: :user, message: "Sorry user, you can't vote for the same work twice." }
end
