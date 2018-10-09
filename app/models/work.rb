class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  #validates :publication_year, length: { is: 4}

end
