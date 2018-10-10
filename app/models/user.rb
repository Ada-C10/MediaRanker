class User < ApplicationRecord
  has_many :votes, through: :works
end
