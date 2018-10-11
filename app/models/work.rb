class Work < ApplicationRecord
  has_many  :votes

  validates :title, :category, presence: true
  validates_uniqueness_of :title, scope: :category


end
