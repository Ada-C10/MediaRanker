class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user, presence: true, uniqueness: { scope: :work, message: "has already voted for this work" }
  validates :work, presence: true
end
