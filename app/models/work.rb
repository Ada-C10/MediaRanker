require 'pry'
class Work < ApplicationRecord
  # relation - user can have many votes
  has_many :votes
  # validate for unique title
  validates :title, presence: true, uniqueness: true

  def self.list_works_by_category(category)
    works_by_category = []
    work = Work.all
    work.each do |work|
      works_by_category <<
     work unless work[:category] != category
    end
    return works_by_category
  end
end
