class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, length: { in: 5..100 }
  validates :title, uniqueness: true
  validates :category, presence: true
  validates :description, presence: true, length: { in: 5..100 }
  validates :creator, presence: true
  validates :publication_year, presence: true, length: {in:4..5}
  validates :publication_year, numericality: { only_integer: true }

  def self.catergory_list
    return Work.all.map do |work|
      [work.category , work.id]
    end
  end


end
