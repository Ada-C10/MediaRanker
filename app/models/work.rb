class Work < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }
  validates_inclusion_of :category, in: %w(book album movie)
  has_many :users, through: :votes
  has_many :votes

  #this one is working to sort by title 
  default_scope {order(title: :asc)}


  # , -> {group 'works.id'} default_scope {order(title: :desc)}
  # default_scope where(color: 'red')`, please use `default_scope { where(color: 'red') }
  # has_many :votes, -> {group 'works.id'}.order('count(works.id) DESC', 'title ASC')


  def self.albums
    # Company.joins(:jobs).group("companies.id").order("count(companies.id) DESC")
    return Work.where(category: 'album') # Work is the table
    # return Work.joins(:votes).group("works.id").order("count(works.id) DESC")
    # return Work.joins(:votes).group('works.id').order('count(works.id) DESC', 'title ASC')
    #i want to return a list of albums that are sorted by vote count and title
  end

  def self.books
    return Work.where(category: 'book')
  end

  def self.movies
    return Work.where(category: 'movie')
  end

  def sort_by_vote_count
    #sort any list of work objects by title and votes
    #first by votes
    #second priority by title
    return Work.order(votes: :desc, title: :asc)
    #how can i call this method on the albums and books lists?
  end


end

# def sort_by_vote_count
#   #this method sorts vote count in descending order & alphabetically
#   #it needs to be in alphabetical order by vote count (by multiple conditions)
#   # sort_by { |obj| block } → array
#   # users.sort_by { |user| [user.age, user.name] }
#   # ary.sort_by {|name, age| [age, name] }
#   #list = self.sort #sorts alphabetically from a-z
#   #then sort by vote number
#   #check how many votes each work has
#   #sort from greatest to smallest
#   return list.sort_by {|work| [work.votes.count, work.title]}
# end
