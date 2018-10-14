class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  # def change_vote
  #   #toggle vote status false true
  #   vote.status == true ? false : true #if status is true, toggle to false, else toggle to true
  # end
end
