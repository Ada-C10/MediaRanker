class HomeController < ApplicationController
  def index
    @sorted_works = Work.all.sort_by {|work| work.votes.length}.reverse
    @books = @sorted_works.select {|work| work.category == "book" }
    @albums = @sorted_works.select {|work| work.category == "album" }
    @movies =  @sorted_works.select {|work| work.category == "movie" }
  end
end
