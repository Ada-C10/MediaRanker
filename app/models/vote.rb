class Vote < ApplicationRecord
  belongs_to :work, counter_cache: true
  belongs_to :user
  validates_uniqueness_of :work_id, scope: :user_id
end
