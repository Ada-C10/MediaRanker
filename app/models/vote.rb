class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work, counter_cache: true
  validates :user_id, :uniqueness => { :scope => :work_id, message: 'has already voted'}
  validates :work_id, numericality: { only_integer: true }
  validates :user_id, numericality: { only_integer: true }

  # def votes_by_user
  #   return @sorted = vote.id.sort_by &:user_id
  # end

end
