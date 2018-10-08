class Work < ApplicationRecord

  validates :title, presence: true, uniqueness: { scope: [:category] }
  validates :publication_year, inclusion: { in: 1000..Date.today.year, message: "should be a four-digit year"}, allow_blank: true
  validates :category, inclusion: { in: ['book', 'album', 'movie'], message: "should be a book, movie, or album"}
end
