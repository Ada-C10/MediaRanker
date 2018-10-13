class WelcomeController < ApplicationController
  def index
    @works = Work.all
    # SELECT all works for EACH category
    # SHOW work title, publisher, votes
    @movies = @works.select { |work| work.category == "movie" }
    @albums = @works.select { |work| work.category == "album" }
    @books = @works.select { |work| work.category == "book" }
    @spotlight = top_work
  end

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
end
