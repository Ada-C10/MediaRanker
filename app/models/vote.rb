class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true, uniqueness: true
  validates :work_id, presence: true

  # def change_vote
  #   #toggle vote status false true
  #   vote.status == true ? false : true #if status is true, toggle to false, else toggle to true
  # end
end
