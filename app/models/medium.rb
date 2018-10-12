class Medium < ApplicationRecord
  has_many :votes
  validates :title, uniqueness: true, presence: true
  validates :publication_year, numericality: true, presence: true
  validates :category, presence: true

  def self.spotlight
    self.all.max_by do |medium|
      medium.votes.length
    end
  end
end
