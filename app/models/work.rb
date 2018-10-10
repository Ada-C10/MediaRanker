class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true, uniqueness: { scope: [:category] }
  validates :publication_year, inclusion: { in: 1000..Date.today.year, message: "should be a four-digit year"}, allow_blank: true
  validates :category, inclusion: { in: ['book', 'album', 'movie'], message: "should be a book, movie, or album"}

  MEDIA_CATEGORIES = ['movie', 'book', 'album']

  def self.list(media_category)
    check_category(media_category)
    list = Work.select {|work| work.category == media_category}
    return list.sort_by { |work| work.votes.count }.reverse!
  end

  def self.top_ten(media_category)
    return self.list(media_category).first(10)
  end

  def self.media_lists
    media_lists = []
    MEDIA_CATEGORIES.each do |media_category|
      media_lists << self.list(media_category)
    end
    return media_lists.sort
  end

  def self.top_ten_lists
    top_ten_lists = []
    MEDIA_CATEGORIES.each do |media_category|
      top_ten_lists << self.top_ten(media_category)
    end
    return top_ten_lists.sort.reverse
  end

private

  def self.check_category(input)
    if !MEDIA_CATEGORIES.include?(input)
      raise ArgumentError, 'must use a valid media category'
    end
  end

end
