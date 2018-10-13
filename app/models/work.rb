class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :title, uniqueness: true, length: { in: 3..100}
  validates :category, presence: true


  def self.by_category(input)



  end


end
