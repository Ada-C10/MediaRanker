class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :category, presence: true


  def self.by_category(input)
     raise ArgumentError if input != "Movie" && input != "Book" && input != "Album"

      result = Work.all.order(:id).select {|work| work.category == input}

  end
end
