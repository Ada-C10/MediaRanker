class Work < ApplicationRecord
  CATEGORIES = %w(album book movie) #store categories in a constant
  has_many :votes
  has_many :users, through: :votes


  def upvote user
    @vote = Vote.new #create a new vote
    @vote.work_id = self.id #a work's id is assigned vote's foreign key, work_id
    @vote.user_id = user.id #a user's id is assigned to vote's foreign key, user_id
    @vote.vote_time = Date.today #vote's date
    unless @vote.valid? #if vote is not valid...
      puts "#{@vote.errors.messages}" #display error messages
    end
    @vote.save #save vote so user cannot duplicate vote for a work
  end

  def self.to_category_hash #work.to_category
    data = {}
    CATEGORIES.each do |cat| #iterates over each category
      data[cat] = by_category(cat) #data[album, book, movie] = by_category(album, book, movie)
    end
    return data #return data = {album, book, movie}
  end

  def self.by_category(category) #sorts works by category
    category = category.singularize.downcase
    self.where(category: category).order(vote_count: :desc) #where is work's category based on vote count (largest to smallest)?
  end

  def self.top_ten(category) #calls 10 works based on chosen category
    where(category: category).order(vote_count: :desc)[0..10] #descending order
  end


  # def self.top
  #   works = Work.all.to_a
  #   return works.max_by { |work| work.total_votes }
  # end

  def self.highest_albums #call self.top_10 method for album category
    top_ten("album")  #displays up to 10 albums
  end

  def self.highest_books #call self.top_10 method for book category
    top_ten("book") #displays up to 10 books
  end

  def self.highest_movies #call self.top_10 method for movie category
    top_ten("movie")  #displays up to 10 movies
  end







end
