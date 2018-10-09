class Work < ApplicationRecord
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, inclusion: { in: 1000..Date.today.year, message: "should be a four-digit year"}
end
