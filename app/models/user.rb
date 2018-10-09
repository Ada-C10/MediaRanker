class User < ApplicationRecord
  validates :name, presence: true
  has_many :votes, dependent: :nullify

  def created_at
    attributes['created_at'].strftime("%B, %d, %Y")
  end
end
