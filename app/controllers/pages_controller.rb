class PagesController < ApplicationController

  def index
    @top_books = Work.top_ten("Book")
    @top_movies = Work.top_ten("Movie")
    @top_albums = Work.top_ten("Album")

    @top_media = Work.top_media

  end
end
