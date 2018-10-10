class PagesController < ApplicationController
  def home
    @albums = Work.by_category("album").limit(10)
    @books = Work.by_category("book").limit(10)
    @movies = Work.by_category("movie").limit(10)
  end
end
