class PagesController < ApplicationController
  def index
    @works = Work.order(votes_count: :desc)
    @books = @works.where(category: 'book')
    @albums = @works.where(category: 'album')
    @movies = @works.where(category: 'movie')
  end
end
