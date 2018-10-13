class User < ApplicationRecord
  has_many :votes, dependent: :delete_all
  has_many :works, through: :votes
  validates_presence_of :user_name
end
