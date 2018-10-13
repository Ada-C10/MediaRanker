class User < ApplicationRecord
  has_many :works

validates :user_name, :id, presence: true


end
