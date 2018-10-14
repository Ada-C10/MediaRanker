class Work < ApplicationRecord
  has_many :votes

  validates :title, :creator, :category, :description, :publication_year, presence: true

  def self.works_by_category(category)
    return works = Work.where(category: category)
  end

end
