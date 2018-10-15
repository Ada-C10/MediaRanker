class Vote < ApplicationRecord
  belongs_to :medium
  belongs_to :user
end
