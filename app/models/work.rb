class Work < ApplicationRecord
#belongs_to :user

validates :category, presence: true
validates :title, presence: true
validates :creator, presence: true
validates :publication_year, presence: true
validates :description, presence: true
end
