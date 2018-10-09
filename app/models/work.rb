class Work < ApplicationRecord
  # CATEGORIES = ["album", "book", "movie"]
  has_many :votes

  validates :title, presence: true, uniqueness: true
  # validates_inclusion_of :category, :in => CATEGORIES


  #QUESTION: uniqueness: really?? depends on media type, no?
def categories
  @categories = ["album", "book", "movie"] 
end
end
