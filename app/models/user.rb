class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { in: 2..50 }
end
