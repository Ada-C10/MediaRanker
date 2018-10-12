class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :category, presence: true


  def self.by_category(input)
      result = Work.all.select {|work| work.category == input}
      return result
  end
end
