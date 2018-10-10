class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def show; end

  def new
    @work = Work.new
  end

  def edit; end

  def update
    if @work && @work.update(work_params) #(if book exists AND can be updated)
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = "#{work.title} has been added to the site."
      redirect_to root_path
    else
      flash.now[:error] = 'Work has not been added!'
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
    end
      render :new # show the new book form view again
  end

  def sort_category #sorting categories for view

  end

  def destroy
    if @work != nil
      @work.destroy
      flash[:success] = "#{work.title} has been removed from the site."
      redirect_to root_path
    end

  end

  private

  def find_work
    id = params[:id].to_i
    @work = Work.find_by(id: id)

    if @work.nil?
      flash.now[:warning] = "Sorry, we can't find what you are looking for."
     render :not_found, status: :not_found
    end
  end

  def work_params
    return params.require(:work).permit(:id, :creator, :category, :year, :description)
  end
end
