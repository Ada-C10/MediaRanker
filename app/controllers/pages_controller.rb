class PagesController < ApplicationController

  def index

    @top_books = Work.top_ten("book")
    @top_movies = Work.top_ten("movie")
    @top_albums = Work.top_ten("album")

    @top_media = Work.top_media

  end
end
