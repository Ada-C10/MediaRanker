class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user, presence: true, uniqueness: { scope: :work, message: "You may only vote on this work once."}
  validates :work, presence: true

end
