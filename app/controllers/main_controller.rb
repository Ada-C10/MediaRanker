class MainController < ApplicationController
  def index
    @works = Work.order(:title)

  end
end
