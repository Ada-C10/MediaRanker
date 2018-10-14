class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  # validations goes here: user and work combo is unique...
  validates :title, presence: true, uniqueness: {scope: :creator, :message => "and creator combination already exists"}
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: Date.today.year + 1}

  CATEGORIES = %w[album book movie]

  def self.get_works_of_type(category)
      return Work.where(category: category).sort_by { |work| work.votes.count}.reverse
  end

  def self.top_ten(category)
    return get_works_of_type(category)[0..9]
  end

  def self.get_categories
    return CATEGORIES
  end

  def self.top_media
    return Work.all.max_by { |work| work.votes.count }
  end




end
