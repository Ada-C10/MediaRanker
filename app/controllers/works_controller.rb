class WorksController < ApplicationController
before_action :find_work, only: [:show, :edit, :update, :destroy]
before_action :find_work_votes, only: [:show]

  def index
    @works = Work.all
  end

  def show
    if @work == nil
      flash.now[:failure] = "Work not found. Please use one of the options above."
      render 'layouts/invalid_page', status: :not_found
    end
  end

  def new
    @work = Work.new()
  end

  def create
    filtered_params = work_params()
    @work = Work.new(filtered_params)

    if @work.save
      flash[:success] = "The #{@work.category} '#{@work.title}' was successfully added."
      redirect_to works_path
    else
      flash.now[:failure] = "The work #{@work.title} was not added."
      render :new, status: 400
    end
  end

  def edit; end

  def update
    is_successful_update = @work.update(work_params)

    if is_successful_update
      flash[:success] = "Work #{@work.title} was successfully updated."
      redirect_to work_path(@work)
    else
      flash.now[:failure] = "Work #{@work.title} was not updated."
      render :edit
    end
  end

  def destroy

    is_successful_deletion = @work.destroy

    if is_successful_deletion
      flash[:success] = "Work #{@work.title} successfully deleted."
      redirect_to works_path
    else
      flash[:failure] = "Work #{@work.title} not destroyed."
      #flash back
      redirect_back fallback_location: root_path
    end
  end

  private

  #strong params
  def work_params
    return params.require(:work).permit(
      :category,
      :title,
      :creator,
      :publication_year,
      :description
    )
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def find_work_votes
    @work_votes = @votes.find_votes_by_work(params[:id])
  end
end
