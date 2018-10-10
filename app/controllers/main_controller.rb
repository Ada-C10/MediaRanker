class MainController < ApplicationController
  def index
    @albums = Work.where(category: "album").limit(10)
    @movies = Work.where(category: "movie").limit(10)
    @books = Work.where(category: "book").limit(10)
    @spotlight = Work.first
  end
end
