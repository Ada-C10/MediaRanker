class User < ApplicationRecord
  validates :name, presence: true
  has_many :votes

  def created_at
    attributes['created_at'].strftime("%B, %d, %Y")
  end
end
