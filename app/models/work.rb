class Work < ApplicationRecord
  VALID_CATEGORIES =  %w( movie book album )
  has_many :votes, dependent: :destroy
  validates :title, presence: true, uniqueness: { scope: :category, message: "this work was already added for this category" }
  validates_inclusion_of :category, :in => VALID_CATEGORIES, message: "Category must be 'movie', 'book', or 'album' [Case Sensitive]"
end
