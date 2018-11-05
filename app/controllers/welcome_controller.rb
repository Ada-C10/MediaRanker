class WelcomeController < ApplicationController
  def index
    @works = Work.all
    # Show top ten for each category to view 
    @movies = top_ten_list("movie")
    @albums = top_ten_list("album")
    @books = top_ten_list("book")
    @spotlight = top_work
  end

  private

  def top_work
    # TODO What if there's no works?
    # Access array of works
    # Select work with most votes
    # If no votes for any works, select random work
    if @works.all? {|work| work.votes.empty? }
      return @works[ rand(0..( works.length-1 )) ]
    else
      @works.max_by { |work| work.votes_count}
    end
  end

  def top_ten_list(category)
    # Select all of category from work instances
    work_by_category = Work.all.select { |work| work.category == "#{category}" }
    # Return max by vote count for top 10
    return work_by_category.max_by(10) { |work| work.votes_count }
  end
end
