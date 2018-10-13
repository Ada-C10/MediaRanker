require 'pry'
class Work < ApplicationRecord
  # relation - user can have many votes
  has_many :votes
  # validate for unique title
  validates :title, presence: true, uniqueness: true

  def self.works_by_category(category)
    filtered_work_list = []
    work = Work.all
    work.each do |work|
      filtered_work_list <<
     work unless work[:category] != category
    end
    return filtered_work_list
  end
end
