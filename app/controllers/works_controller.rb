class WorksController < ApplicationController
  def home
  end

  def index
  end

  def show
    @work = Work.find(params[:id].to_i)
    if @work.nil?
      render :notfound, status: :not_found
    end
  end

  def new
  end
end
