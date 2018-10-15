class Work < ApplicationRecord
  # QUESTION: how to get this to work? CATEGORIES = ["album", "book", "movie"]
  has_many :votes, dependent: :delete_all

  validates :title, presence: true, uniqueness: {scope: :categoy, message: "This category already knows about that title." }
  # TODO: validates :publication_year --> how to get year only??

  # TODO: necessary???? validates_inclusion_of :category, :in => CATEGORIES

  def self.work_categories
    @categories = ["album", "book", "movie"]
  end

  def count_votes
    return self.votes.length
  end

  def self.sort_works(works)
    works_by_vote = works.sort_by{|work| work.count_votes}.reverse
    return works_by_vote
  end

  def self.gen_top_ten_works(works_by_category)
    works_by_vote = self.sort_works(works_by_category)
    @top_ten = works_by_vote.first(10)
    return @top_ten
  end


  def self.gen_top_work(all_works)
    works_by_vote = self.sort_works(all_works)
    @top_work = works_by_vote.first
    return @top_work
  end


  # TODO: grammar---> don't show for 0, 1 vote, x>1 votes

end
