class WorksController < ApplicationController
  def index
    @work = Work.all
  end

  def delete
  end

  def edit
  end

  def show
    id = params[:id].to_i
    @work = Work.find_by(id: id)
    if @work.nil?
      render :notfound, status: :notfound
    end
  end

  def update
  end

  def upvote
  end
end
