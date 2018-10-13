class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  validates :work_id, presence: true

  def self.duplicated_votes (user_id, work_id)
    Vote.where(user_id:user_id, work_id:work_id).present?
  end
end
