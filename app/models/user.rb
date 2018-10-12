class User < ApplicationRecord

    validates :username, presence: true, uniqueness: true, format: {with: /\A[-_a-z0-9]+\Z/}, length: {maximum: 15}
end
