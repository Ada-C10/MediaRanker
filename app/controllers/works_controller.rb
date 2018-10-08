class WorksController < ApplicationController
  def index
    @works = Work.order(:name)
  end

  def create
  end
end
