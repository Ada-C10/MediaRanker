class WelcomeController < ApplicationController

  def index
    @albums = Work.gen_top_ten_works('album')
    @books = Work.gen_top_ten_works('book')
    @movies = Work.gen_top_ten_works('movie')

    @spotlight = Work.gen_top_work
  end
end
