class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :works, through: :votes

  validates :name, presence: true

  def disp_votes
    user_votes = self.votes

    return user_votes
  end
  
end
