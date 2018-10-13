class HomesController < ApplicationController

  def index
    @works = Work.all
  end
end
