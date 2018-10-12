class User < ApplicationRecord
  has_many :votes, dependent: :delete_all

  # TODO: maybe add minimum length??
  validates :username, presence: true, uniqueness: true

end
