class Vote < ApplicationRecord
  validates :user, uniqueness: { scope: :user_id,
    message: "should happen once per user" }
  belongs_to :work
  belongs_to :user
end
