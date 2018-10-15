class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  validates :work_id, presence: true

  def self.count_votes(work_id)
    count = 0
    votes = Vote.all
      votes.find_all do |vote|
        count += 1 if vote.work_id == work_id
      end

      return count
  end

end
