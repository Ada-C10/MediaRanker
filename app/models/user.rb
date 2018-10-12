class User < ApplicationRecord
  has_many :votes
  validates :name, presence: true, uniqueness: { case_sensitive: false },
    length: { in: 6..20 }, format: { with: /(\w|-){6,20}/, message: "Only letters, underscores, and dashes allowed" }
end
