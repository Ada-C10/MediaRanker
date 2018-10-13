class WorksController < ApplicationController

  def welcome
    @ordered_works = Work.joins('LEFT JOIN votes ON work_id = works.id')
                 .group('works.id')
                 .order('count(votes.id) DESC')

    @works = @ordered_works
  end

  def index
    @works = Work.joins('LEFT JOIN votes ON work_id = works.id')
                 .group('works.id')
                 .order('count(votes.id) DESC')
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to works_path
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
    end

  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
    end

    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      head :not_found
    end

    redirect_to root_path
  end

  def upvote
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
    end

    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:error] = "A problem occurred: You must be logged in to do that"
      redirect_back(fallback_location: root_path)

    else
      @vote = Vote.new(user: @user, work: @work)

    # add another conditional here for checking if vote already exists for user

      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_to works_path
      else
        flash[:error] = "Something went wrong - cannot vote same one"
        redirect_back(fallback_location: root_path)
      end

    end


  end



private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
