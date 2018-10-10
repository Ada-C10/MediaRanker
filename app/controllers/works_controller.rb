class WorksController < ApplicationController
  def index
    @current_user = User.find_by(id: session[:user_id])
    # user id will be nil if not logged in or whole author model if they are logged in

    @works = Work.all
  end

  def show
    @current_user = User.find_by(id: session[:user_id])
    # user id will be nil if not logged in or whole author model if they are logged in

    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      render :notfound, status: :not_found
    end
  end

  def new
    @current_user = User.find_by(id: session[:user_id])
    # user id will be nil if not logged in or whole author model if they are logged in

    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Work added"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Error: Work not added"

      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new
    end
  end

  def edit
    @current_user = User.find_by(id: session[:user_id])
    # user id will be nil if not logged in or whole author model if they are logged in

    @work = Work.find_by(id: params[:id].to_i)
  end

  def update
    @work = Work.find_by(id: params[:id].to_i)
    if @work.update(work_params)
      flash[:success] = "Changes saved"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Error: Changes not saved"

      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :edit
    end
  end

  def destroy
    work = Work.find_by(id: params[:id].to_i)
    deleted_work = work.destroy

    flash[:success] = "#{deleted_work.title} deleted"

    redirect_to root_path
  end

  private

    def work_params
      return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    end
end
