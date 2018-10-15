class Work < ApplicationRecord
  # QUESTION: how to get this to work? CATEGORIES = ["album", "book", "movie"]
  has_many :votes, dependent: :delete_all

  validates :title, presence: true, uniqueness: {scope: :category, message: "This category already knows about that title." }
  # TODO: validates :publication_year --> how to get year only??

  # TODO: necessary???? validates_inclusion_of :category, :in => CATEGORIES

  def self.work_categories
    @categories = ["album", "book", "movie"]
  end

  def self.categorize_works(work_category)
    return self.where(category: work_category)
  end

  def self.sort_works(work_category)
    cat_works_array = categorize_works(work_category)
    works_by_vote = cat_works_array.sort_by{|work| work.count_votes}.reverse
    return works_by_vote
  end

  def self.gen_top_ten_works(work_category)
    works_by_vote = self.sort_works(work_category)
    @top_ten = works_by_vote.first(10)
    return @top_ten
  end


  def self.gen_top_work
    all_works = Work.all
    all_works_by_vote = all_works.sort_by{|work| work.votes.length}
    @top_work = all_works_by_vote.last #sort_by --> ascending order
    return @top_work
  end


  # TODO: grammar---> don't show for 0, 1 vote, x>1 votes

end
