class Work < ApplicationRecord
  # relation - user can have many votes
  has_many :votes
  # validate for unique title
  validates :title, presence: true, uniqueness: true
end
