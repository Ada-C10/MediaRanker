class WorksController < ApplicationController
  def index
    @works = Work.order(:name)
  end

  def show
  end

  def new
  end 

  def create
  end


end
