class WelcomeController < ApplicationController
  def index
    @works = Work.all
    # SELECT all works for EACH category
    # SHOW work title, publisher, votes
    @movies = @works.select { |work| work.category == "movie" }
    @albums = @works.select { |work| work.category == "album" }
    @books = @works.select { |work| work.category == "book" }


    # Does not know what works are :(
    # Do I need to figure out the seed issue/seupt the controllers the rest of the way?
    # Does it need a relationship to works?
  end
end
