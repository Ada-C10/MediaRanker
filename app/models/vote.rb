class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work, counter_cache: true

  validates_uniqueness_of :work_id, scope: :user_id
end
