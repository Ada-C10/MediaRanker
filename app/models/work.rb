class Work < ApplicationRecord
  validates :catogory, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  has_many :votes
end
