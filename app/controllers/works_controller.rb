class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @works = Work.all.order(:title)
  end

  def show; end

  def new
    @work = Work.new
  end

  def edit; end

  def destroy
    unless @work.nil?
      @work.destroy
      flash[:success] = "#{@work.title} deleted"

      redirect_to works_path
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      puts "#{@work.errors}"
      render :new
    end
  end

  def update
    if @work && @work.update(work_params)
      redirect_to work_path(@work.id)
    elsif @work
      render :edit
    end
  end

  # def upvote
  #   if Vote.find_by(user_id: @current_user.id) == nil
  #
  #     @vote = Vote.new(quantity: 1, user_id: @current_user.id, work_id: @work.id)
  #
  #     if @vote.save
  #       redirect_back fallback_location: works_path
  #     else
  #       puts "#{@vote.errors}"
  #     end
  #   else
  #     flash.now[:warning] = "Cannot vote twice"
  #   end
  # end

  def upvote
    @vote = Vote.new(quantity: 1, user_id: @current_user.id, work_id: @work.id)
    raise
    if @vote.save
      redirect_back fallback_location: works_path
    else
      puts "#{@vote.errors}"
    end
  end


  private

  def find_work
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      flash[:warning] = 'Cannot find the work'
      redirect_to root_path
    end
  end

    def work_params
      return params.require(:work).permit(:title, :creator, :publication_year, :description, :category)
    end
end
