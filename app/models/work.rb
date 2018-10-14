class Work < ApplicationRecord
belongs_to :user
<<<<<<< HEAD
has_many :votes
=======
has_many :votes, dependent: :destroy


>>>>>>> voting
validates :category, presence: true
validates :title, presence: true
validates :creator, presence: true
validates :publication_year, presence: true
validates :description, presence: true
end
