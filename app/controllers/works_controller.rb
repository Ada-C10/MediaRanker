class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @works = Work.all
  end

  def show; end
    
  def new
    @work = Work.new
  end

  def edit; end

  def create
    @work = Work.new(work_params)

    respond_to do |format|
      if @work.save
        flash[:success] = 'Work successfully created'
        format.html { redirect_to @work, notice: 'Work was successfully created.' }
      else
        flash.now[:warning] = 'Work not created!'
        @work.errors.messages.each do |field, messages|
          flash.now[field] = messages
        end
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @work.update(work_params)
        # flash[:primary] = 'Work was successfully updated.'
        # redirect_to work_path(@work.id)
        format.html { redirect_to @work, notice: 'Work was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url, dark: 'Work was successfully destroyed.' }
    end
  end

  def upvote
    if @current_user.nil?
      flash[:warning] = 'You must be logged in to vote.'
      redirect_back(fallback_location: root_path)
    else
      work, user = @work.id, @current_user.id
      if @current_user.votes.where(work_id: work).empty?
        @work.votes.create(work_id: work, user_id: user)
        flash[:success] = "Upvote successful."
        redirect_back(fallback_location: root_path)
      else
        flash[:danger] = 'A user can only vote on each work once.'
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def top
    @spot = Work.spotlight?
    @albums = Work.top?("album")
    @books = Work.top?("book")
    @movies = Work.top?("movie")
  end

  def spotlight
    @spot = Work.spotlight?
  end



  private
    # Use callbacks to share common setup or constraints between actions.
  def set_work
    @work = Work.find_by(id: params[:id].to_i)
    if @work.nil?
      flash.now[:warning] = 'Work not found'
      render :notfound
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def work_params
    params.require(:work).permit(:title, :creator, :description, :category, :publication_year)
  end
end
