class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work_id, uniqueness: {scope: :user_id, message: "You have already voted for this work."}

  def get_work
    @work = Work.find(self.work_id)
  end
end
