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

  def upvote
    work = Work.find_by(id: params[:id].to_i)
    user = User.find_by(id: session[:user_id])

    if user.nil?
      flash[:error] = "A problem occurred: You must log in to vote"

      work.errors.messages.each do |field, messages|
        flash[field] = messages
      end

      redirect_back(fallback_location: root_path)

    elsif !user.works.include? work # user eligible to vote
      vote = Vote.new(work: work, user: user)

      if vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      else
        flash[:error] = "Error: Could not process vote"

        work.errors.messages.each do |field, messages|
          flash[field] = messages
        end

        redirect_back(fallback_location: root_path)
      end

    else # user.votes.works.include? work # user ineligible to vote
      flash[:error] = "A problem occurred: You've already voted on this work"

      work.errors.messages.each do |field, messages|
        flash[field] = messages
      end

      redirect_back(fallback_location: root_path)
    end
  end

  private

    def work_params
      return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    end
end
