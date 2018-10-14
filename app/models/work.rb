class Work < ApplicationRecord
belongs_to :user
has_many :votes, dependent: :destroy


validates :category, presence: true
validates :title, presence: true
validates :creator, presence: true
validates :publication_year, presence: true
validates :description, presence: true
end
