class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all

  validates :title, :description, :creator, :category, presence: true
  validates :published, numericality: true

  def self.get_media(type)
    works = Work.all.where(category: type)
    works.sort_by {|work| work.votes.count}.reverse!
  end


  def self.top_ten(type)
    works = Work.all.where(category: type)
    works = works.sort_by {|work| work.votes.count}.reverse!
    works[0..9]
  end

  def self.top_work
    work = Work.all.max_by {|work| work.votes.count}
  end

end
