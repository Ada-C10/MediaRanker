class Work < ApplicationRecord
  # CATEGORIES = ["album", "book", "movie"]
  has_many :votes, dependent: :delete_all

  validates :title, presence: true
  # , uniqueness: true
  # validates_uniqueness_of :work, scope: :category
  # validates_inclusion_of :category, :in => CATEGORIES

    CATEGORIES = ["album", "book", "movie"]



  def self.sort_works(works)
    works_by_vote = works.sort{|work| work.votes.length}.reverse
  end

  def self.gen_top_ten_works(works_by_category)
  # def self.top_ten_works(works)
    # CATEGORIES.each do |category|
    #   works.each do |work|
    #     work
    #   end
    # end

    works_by_vote = sort_works(works_by_category)
    @top_ten = works_by_vote.first(10)
    return @top_ten
  end


  def self.gen_top_work(all_works)
    works_by_vote = sort_works(all_works)
    @top_work = works_by_vote.first
    return @top_work
  end


  #QUESTION: uniqueness: really?? depends on media type, no?

end
