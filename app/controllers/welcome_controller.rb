class WelcomeController < ApplicationController
  def index
    @works = Work.all
    # SELECT all works for EACH category
    # SHOW work title, publisher, votes
    @movies = @works.select { |work| work.category == "movie" }
    @albums = @works.select { |work| work.category == "album" }
    @books = @works.select { |work| work.category == "book" }
  end
end
