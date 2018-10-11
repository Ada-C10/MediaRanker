class PagesController < ApplicationController
  def home
    @top_work = Work.all_sorted.first
    @albums = Work.by_category("album").limit(10)
    @books = Work.by_category("book").limit(10)
    @movies = Work.by_category("movie").limit(10)
  end
end
