class User < ApplicationRecord
  has_many :votes, dependent: :delete_all
  validates :name, presence: true, uniqueness: true

  def join_date
    return self.created_at.strftime("%b %d, %Y")
  end
end
