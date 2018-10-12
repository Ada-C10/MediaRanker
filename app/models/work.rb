class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  
  validates :title, presence: true, uniqueness: { scope: :category }
  #validates :publication_year, length: { is: 4}
  validates :category, inclusion: { in: %w(movie album book),
    message: "%{value} is not a valid size" }


  def self.category(media)
      return Work.all.order(:title).select {|work| work.category == media}
  end

end
