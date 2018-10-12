class Work < ApplicationRecord
  has_many  :votes, counter_cache: :counter_of_votes

  validates :title, :category, presence: true
  validates_uniqueness_of :title, scope: :category
  scope :featured, -> {order('votes_count DESC')}

  
end
