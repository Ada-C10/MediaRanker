class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, length: { in: 5..100 }
  validates :title, uniqueness: true
  validates :category, presence: true
  validates :description, presence: true, length: { in: 5..100 }
  validates :creator, presence: true
  validates :publication_year, presence: true, length: {in:4..5}
  validates :publication_year, numericality: { only_integer: true }

  scope :albums, -> { where(category: 'album') }
  scope :movies, -> { where(category: 'movie') }
  scope :books, -> { where(category: 'book') }


  # def self.by_category(category)
  #   category = category.singularize.downcase
  #   self.where(category: category).order(votes: :desc)
  # end

 #  def self.top_ten(category)
 #   where(category: category).order(votes: :desc).limit(10)
 # end
 #
 #  def self.best_albums
 #    top_ten("album")
 #  end

end
