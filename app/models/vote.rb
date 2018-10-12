class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work_id, uniqueness: {scope: :user_id, message: "You have already voted for this work."}

  def get_work
    @work = Work.find(self.work_id)
  end

  def get_user
    @user = User.find(self.user_id)
  end
end
