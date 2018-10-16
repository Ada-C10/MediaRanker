class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :vote]

  def index
    @works = Work.all
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def new
    @work = Work.new
  end

  def destroy
    work = Work.find_by(id: params[:id])
    work.destroy
    redirect_to root_path
  end

  def show
    work_id = params[:id]
    @work= Work.find_by(id: work_id)
    if @work.nil?
      head :not_found
    end
  end

  def update
    @work = Work.find(params[:id])
    @work.update(work_params)
    redirect_to works_path
  end

  def create
    filtered_params = work_params()
    @work = Work.new(filtered_params)
    save_success = @work.save
    if save_success
      redirect_to works_path
    else
      render :new
    end
  end

  def vote
    if @logged_in_user
      if @logged_in_user.votes.find_by(work_id: @work.id)
        flash[:warning] = "A problem occurred: cannot vote twice"
        redirect_back fallback_location: work_path
      else
      @vote = Vote.create(user_id: @logged_in_user.id, work_id: @work.id)
      @vote = @vote.save
      flash[:success] = "success"
      redirect_back fallback_location: work_path
      end
    else flash[:warning] = "A problem occurred: You must log in to do that"
    end
  end

  def sort
    @album = sort_works.album

  end


  private


  def work_params
    return params.require(:work).permit(
      :title,
      :creator,
      :description,
      :publication_year,
      :category,

    )
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
