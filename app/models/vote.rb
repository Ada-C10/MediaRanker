class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  validates :user_id, :work_id, presence: true
  validates_uniqueness_of :user_id, :scope => :work_id
 
  def self.upvote(work, user)
    votes = user.votes
    # binding.pry
    # if votes.where(work_id: work).exists?
    #   flash.now[:notice] =  "You have already upvoted this!"
    #   redirect_to :back
    # else
    upvote = Vote.new(work_id: work, user_id: user)
      
    # end

    return upvote
  end

end
