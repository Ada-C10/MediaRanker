class Work < ApplicationRecord
  has_many :votes

  # validations goes here: user and work combo is unique...
  validates :title, presence: true, uniqueness: {scope: :creator, :message => "and creator combination already exists"}

  CATEGORIES = %w[album book movie]


  def self.top_ten(category)
    return Work.where(category: category)
  end

  def self.get_categories
    return CATEGORIES
  end


  # Category (select)
  # Title
  # Creator
  # Publication year
  # Description (field)
  # Submit "Create Work"



end
