class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :votes, dependent: :nullify

  def self.categories
    return %w(album book movie)
  end

end
