class User < ApplicationRecord
  has_many :works

validates :user_name, presence: true

end
