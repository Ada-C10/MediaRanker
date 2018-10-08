class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
