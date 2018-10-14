class Work < ApplicationRecord
  # relation - user can have many votes
  has_many :votes, dependent: :destroy
  # validate for unique title
  validates :title, presence: true, uniqueness: true

  def self.order_works_by_votes
    works = Work.all
    ordered_works = works.sort_by { |work| work.votes.size }.reverse
    return ordered_works
  end

  def self.top_vote_getter
    return Work.order_works_by_votes.first
  end

  def self.top_vote_getter_votes
    return Work.top_vote_getter.votes.size
  end

  def self.list_works_by_category(category)
    works = Work.all
    works_by_category = works.select { |work| work.category == category }
    return works_by_category
  end

  def self.order_works_by_category(category)
    works_by_category = Work.list_works_by_category(category)
    sorted_works_by_category = works_by_category.sort_by { |work| work.votes.size }.reverse
    return sorted_works_by_category
  end

  def self.top_works_by_category(category, number)
    return Work.order_works_by_category(category).take(number)
  end
end
