class Work < ApplicationRecord
  has_many  :votes

  validates :title, :category, presence: true

end
