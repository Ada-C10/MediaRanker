class WorksController < ApplicationController

  def index
    @works = Work.all.order(:title)
  end

  def show
    id = params[:id]
    @work = Work.find_by(id: id)

    if id == nil
      render :not_found, status: :not_found
    end

  end

  def main
    @works = Work.all
  end

  def edit
    id = params[:id]
    @work = Work.find_by(id: id)
  end

  def new
    @work = Work.new
    if params[:user_id]
      @user_id =  params[:user_id]
      @work.user_id = @user_id
    end
  end

  def update
    id = params[:id]
    @work = Work.find_by(id: id)
    @work.update(work_params)

    if @work.save
      redirect_to work_path # go to the index so we can see the book in the list
    else
      render :new
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "New work created"
      redirect_to work_path(@work.id)
    else # save failed :(
      flash.now[:error] = 'Work not created'
      @work.errors.messages.each do |field, messages|
        flash.now[:field] = messages
      end
      render :new # show the new book form view again
    end
  end

  def upvote
    id = params[:id]
    @work = Work.find_by(id: id)
    @work.upvote(user_id: @current_user.id)
    redirect_to works_path
  end


  def destroy
    id = params[:id]
    @work = Work.find_by(id: id)
    if @work.destroy
      flash[:success] = "#{@work.title} deleted"
      redirect_to root_path
    end
  end

  private
  def work_params
    return params.require(:work).permit(:title, :category, :publication_year, :creator, :description, :user_id)
  end

end
