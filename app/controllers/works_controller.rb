class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :list_top_works, only: [:home]
  before_action :list_all_works, only: [:index]

  def home
    @spotlight = Work.spotlight
  end

  def index; end

  def show
    if session[:user_id]
      @vote = @work.votes.find_by(user_id: session[:user_id])
    end
  end

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
        flash[:success] = "Succesfully edited #{@work.category} \"#{@work.title}!\""
      redirect_to work_path(@work.id)
    elsif @work
      flash[:error] = "Work edits not saved!"
      @work.errors.messages.each do |field, messages|
        flash[field] = messages
      end
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

# Filter for #show, #edit, #update, #destroy
  def find_work
    @work = Work.find_by(id: params[:id].to_i)
    if @work.nil?
      flash.now[:warning] = 'Cannot find the work'
      render :notfound, status: :not_found
    end
  end

# Filter for #home
# Sorts works by votes (desc), then subsorts by title (asc)
  def list_top_works
    # ...should this hash go in the model or the controller?
    @works = Hash.new
  # Find project constants in config/initializers/constants.rb
    VALID_WORK_CATEGORIES.each do |category|
      @works[category] = []
      # Array of works, in ascending order by most recent vote date:
      works_by_category = Work.by_category(category).sort_by {|work| work.most_recent_vote}

      # Array of works, in descending order by votes, subsorted in descending order by most recent vote date:
      works_by_category = works_by_category.sort_by { |work| work.number_of_votes }.reverse!

      # Array of top 10 works, by votes, by title
      works_by_category[0..9].each do |work|
        @works[category] << work
      end
    end
  end

# Filter for #index
# Sorts works by votes (desc), then subsorts by title (asc)
  def list_all_works
    # ...should this hash go in the model or the controller?
    @works = Hash.new
  # Find project constants in config/initializers/constants.rb
    VALID_WORK_CATEGORIES.each do |category|
      # Array of works, in ascending order by most recent vote date:
      works_by_category = Work.by_category(category).sort_by {|work| work.most_recent_vote}

      # Array of works, in descending order by votes, subsorted in descending order by most recent vote date:
      @works[category] = works_by_category.sort_by { |work| work.number_of_votes }.reverse!
    end
  end

  def work_params
    return params.require(:work).permit(:title, :creator, :publication, :category, :description)
  end

end
