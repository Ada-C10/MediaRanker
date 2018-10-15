class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  def date_joined
    self.created_at.strftime("%b %-d, %Y")
  end
end
