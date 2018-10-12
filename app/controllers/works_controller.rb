class WorksController < ApplicationController

before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]

  def homepage
  end

  def index
    #makes a hash grouped by category
     @works = Work.left_joins(:votes).group(:id).order("category asc, count(votes.work_id) desc").group_by(&:category)
     #Work.all.order(category: :asc).group_by(&:category)
  end

  def new
    @work = Work.new
  end

  def show
    if @work.nil?
      head :not_found
    end
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      # flash[:success] = "Successfully created new work \"#{@work.title}\""
      redirect_to works_path
    else
      # flash.now[:error] = "Invalid work data"
      render :new,  status: :bad_request
    end
  end

  def edit
    if @work.nil?
      head :not_found
    end
  end

  def update
    if @work.nil?
      head :not_found
    end
    is_updated = @work.update(work_params)
    if is_updated
      redirect_to work_path(@work)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
      if @work.nil?
        head :not_found
      end

      if @work.destroy
        redirect_to works_path
      else
        render :show
      end
    end


    def upvote
      # @work = Work.find(params[:id])
      # pass in user_id to find user
      # @work.votes.create(user_id: session[:user_id])

      if @work.votes.count == 0
        @work.votes.create(user_id: session[:user_id])
        redirect_to(works_path)
      else flash[:error] = "User has already voted for this work"
        redirect_to(works_path)

      end
    end




  private

    def work_params
      return params.require(:work).permit(
        :category, :title, :creator, :description, :publication_year)
    end

    def find_work
      @work = Work.find_by(id: params[:id])
    end

end
