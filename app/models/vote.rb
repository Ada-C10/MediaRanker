class Vote < ApplicationRecord

  belongs_to :user
  belongs_to :work

  # validates :vote, uniqueness: true

end
