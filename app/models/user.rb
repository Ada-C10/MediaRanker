class User < ApplicationRecord
has_many :works
has_many :votes

validates :user_name, :id, presence: true


end
