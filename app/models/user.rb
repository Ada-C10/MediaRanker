class User < ApplicationRecord
  has_many :vote

  validates :name, presence: true
end
