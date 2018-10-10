class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work_id, uniqueness: {scope: :user_id, message: "You can only vote once!"}

  end
