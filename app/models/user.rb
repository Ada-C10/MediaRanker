class User < ApplicationRecord

  # relation - user can have many votes
  has_many :votes
  # validate name exists and is unique
  validates :name, presence: true, uniqueness: true
end
