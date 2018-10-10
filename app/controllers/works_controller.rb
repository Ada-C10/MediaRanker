class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :list_works, only: [:home, :index]

  def home
  end

  def index
  end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = "Succesfully created new #{@work.category} \"#{@work.title}!\""
      redirect_to works_path # go to the index so we can see the book in the list
    else # save failed :(
      flash[:error] = "Work not created!"
      @work.errors.messages.each do |field, messages|
        flash[field] = messages
      end
      redirect_to new_work_path
      # I think we're supposed to use render :new, but don't I want the url to change...?
    end
  end

  def edit; end

  def update
    if @work && @work.update(work_params)
      redirect_to work_path(@work.id)
    elsif @work
      render :edit
    end
  end

  def destroy
    unless @work.nil?
      @deleted_work = @work.destroy
      flash[:success] = "#{@work.title} deleted"
      redirect_to root_path
    end
  end

  private

# Filter
  def find_work
    @work = Work.find(params[:id].to_i)
    if @work.nil?
      flash.now[:warning] = 'Cannot find the work'
      render :notfound, status: :not_found
    end
  end

# Filter
  def list_works
    @works = Hash.new
  # Find project constants in config/initializers/constants.rb
    VALID_WORK_CATEGORIES.each do |category|
      @works[category] = []
      Work.by_category(category).each do |work|
        @works[category] << work
      end
    end
  end

  def work_params
    return params.require(:work).permit(:title, :creator, :publication, :category, :description)
  end

end
