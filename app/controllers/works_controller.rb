class WorksController < ApplicationController
  def home
    @current_user = User.find_by(id: session[:user_id])
    # nil if not logged in, or User model if they are logged in
  end

  def index
    @section_headers = []
    @work_titles = []
# Find project constants in config/initializers/constants.rb
    VALID_WORK_CATEGORIES.each do |cat|
      @section_headers << "ALL" + "#{cat.upcase}" + "S"
      Work.by_category(cat).each do |wrk|
        @work_titles << wrk.title
      end
    end

  end

  def show
    @work = Work.find(params[:id].to_i)
    if @work.nil?
      render :notfound, status: :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Succesfully created new #{@work.category}: #{@work.title}!"
      redirect_to work_path(@work.id)
    else
      flash[:failure] = "There was a problem saving the new work. Try again?"
      flash[:errors] = @work.errors
      redirect_to new_work_path
      # render :new
    end
  end


  private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication, :category, :description)
  end

end
