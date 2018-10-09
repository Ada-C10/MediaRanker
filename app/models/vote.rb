class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user
  # belongs_to triggers validation error by default

  scope
end
