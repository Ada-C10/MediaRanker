class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  validates :work_id, presence: true



  validates :work, uniqueness: {
    scope: :user, message: "A user can't vote for same twice"
  }



#slow
#get all works
#each work get votes
#then sort


#fast way, sort votes in the model


end
