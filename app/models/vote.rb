class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  validates_uniqueness_of :user_id, uniqueness: { scope: :work_id, message: "Can only vote once per work" }
  validates :work_id, presence: true

end
