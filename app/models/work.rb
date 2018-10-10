class Work < ApplicationRecord
  has_many :votes

  validates :category, :title, presence: true

end
