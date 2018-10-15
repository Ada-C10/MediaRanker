class Work < ApplicationRecord
  has_many  :votes, counter_cache: :counter_of_votes
  has_many :votes, :dependent => :destroy

  validates :title, :category, presence: true

  validates_uniqueness_of :title, scope: :category
  scope :featured, -> {order('votes_count DESC')}

  # def top_media_find
  #   works = Work.all
  #   works.sort_by {|vote|}
  #   top = works.first
  #
  #   return top
  # end


end
