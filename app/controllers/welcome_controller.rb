class WelcomeController < ApplicationController

  def index
    # CATEGORIES.each do
    #
    # end
    # TODO: dry this up!!
    albums = Work.where(category: 'album')
    books = Work.where(category: 'book')
    movies = Work.where(category: 'movie')
    all_works = Work.all

    @albums = Work.gen_top_ten_works(albums)
    @books = Work.gen_top_ten_works(books)
    @movies = Work.gen_top_ten_works(movies)

    @spotlight = Work.gen_top_work(all_works)

  end
end
