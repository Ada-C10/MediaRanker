class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true

  def score
    votes.count
  end

end
