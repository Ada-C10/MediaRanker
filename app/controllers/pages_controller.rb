class PagesController < ApplicationController
  def index
    @works = Work.all
    @books = Work.where(category: 'book').first(10)
    @albums = Work.where(category: 'album').first(10)
    @movies = Work.where(category: 'movie').first(10)
  end
end
