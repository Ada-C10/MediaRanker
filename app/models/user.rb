class User < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true
  has_many :votes
end
