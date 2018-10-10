class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :category }
  #validates :publication_year, length: { is: 4}

end
