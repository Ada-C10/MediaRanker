class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  def find_work_id
    return self.id
  end

  def total_votes
    work_id = find_work_id

    array_of_votes = Vote.where(work_id: work_id)
    num_of_votes = array_of_votes.count

    return num_of_votes
  end
end
