class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true, uniqueness: true
  validates :work_id, presence: true, uniqueness: true

  def already_voted?
    @current_user.votes.each do |vote|
      if vote.work_id == @work.id
        return true
      else
        return false
      end
    end
  end
end
