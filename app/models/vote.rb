class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :vote_date, allow_nil: true
end
