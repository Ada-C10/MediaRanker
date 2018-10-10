class Work < ApplicationRecord
  has_many :votes

  # validations goes here: user and work combo is unique...
  validates :title, presence: true, uniqueness: {scope: :creator, :message => "and creator combination already exists"}
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: Date.today.year + 1}

  CATEGORIES = %w[album book movie]


  def self.top_ten(category)
    return Work.where(category: category)
  end

  def self.get_categories
    return CATEGORIES
  end

  def self.get_plural_categories
    return CATEGORIES.map { |category| category.pluralize }
  end

end
