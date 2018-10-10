class Vote < ApplicationRecord
  belongs_to :users
  belongs_to :works

  validates :work_id, uniqueness: { scope: :user_id, message: "You can only vote once for this work" }
end
