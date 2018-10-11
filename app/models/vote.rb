class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :user, uniqueness: { scope: [:work], message: 'has already voted for this work'}

  def upvote_date
    return self.created_at.strftime("%b %d, %Y")
  end

end
