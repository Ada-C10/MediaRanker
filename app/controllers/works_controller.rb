class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def home
    # @current_user = User.find_by(id: session[:user_id])
    # nil if not logged in, or User model if they are logged in
  end

  def index
    @section_headers = []
    @work_titles = []
# Find project constants in config/initializers/constants.rb
    VALID_WORK_CATEGORIES.each do |cat|
      @section_headers << "ALL " + "#{cat.upcase}" + "S"
      Work.by_category(cat).each do |work|
        @work_titles << work.title
      end
    end

  end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = "Succesfully created new #{@work.category}: #{@work.title}!"
      redirect_to works_path # go to the index so we can see the book in the list
    else # save failed :(
      flash.now[:error] = "Work not created!"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new
    end
  end

#   def create
#   @book = Book.new(book_params)
#   if @book.save # save returns true if the database insert succeeds
#     flash[:success] = 'Book Created!'
#
#     redirect_to root_path # go to the index so we can see the book in the list
#   else # save failed :(
#     flash.now[:error] = 'Book not created!'
#     @book.errors.messages.each do |field, messages|
#       flash.now[field] = messages
#     end
#
#     render :new # show the new book form view again
#   end
# end

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

  def work_params
    return params.require(:work).permit(:title, :creator, :publication, :category, :description)
  end

end
