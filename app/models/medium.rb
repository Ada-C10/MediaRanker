class Medium < ApplicationRecord
  has_many :votes

  def self.spotlight
    self.all.max_by do |medium|
      medium.votes.length
    end
  end
end
