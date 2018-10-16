class HomeController < ApplicationController
  def index
    @works = sort_by_votes(Work.all.order(created_at: :asc))
  end
end
