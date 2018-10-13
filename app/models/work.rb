class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :title, uniqueness: true, length: { in: 3..100}
  validates :category, presence: true

  validates_inclusion_of :category, :in => ['book', 'album','movie']

  def self.book_list
    Work.all.order(:created_at).select {|work| work.category = "book"}


  end


end
