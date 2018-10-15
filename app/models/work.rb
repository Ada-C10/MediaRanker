class Work < ApplicationRecord

  WORK_CATEGORIES = %w(album movie book)

  has_many :votes
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: WORK_CATEGORIES}

  def self.get_category_media(category)
    works = Work.where(category: category).to_a
    return works
  end

  def self.get_top_list(category)
    # works.each do |work|
      # works.sort_by {|item| item.votes}
      # index = 0
      # top_works = []
      #
      # while index < num
      #   top_works < list[index]
      #   index += 1
      # end
      #
      # return top_works

      category_works = Work.get_category_media(category).to_a
      sorted = category_works.sort_by{|item| item[:votes]}
      return sorted[0..9]
    end

  def self.get_top_work
    works = Work.all.to_a
    highest= works.sort_by{|item| item[:votes]}.reverse
    return highest.first
  end

end
