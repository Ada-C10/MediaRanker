class PagesController < ApplicationController
  def home
    works = Work.all.order('vote_count DESC, title')
    @books = works.all.where(category: "book").limit(10)
    @movies = works.all.where(category: "movie").limit(10)
    @albums = works.all.where(category: "album").limit(10)
  end
end
