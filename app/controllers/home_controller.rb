class HomeController < ApplicationController
  def index
    @works = Work.all
    @sorted_works = @works.sort_by {|work| work.votes.length}.reverse
  end
end
