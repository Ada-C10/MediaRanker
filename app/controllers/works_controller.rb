class WorksController < ApplicationController
  before_action :find_work, except: [:index, :new, :create]

  def index
    @works = Work.all
  end

  def show; end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      success_redirect("Work added", work_path(@work.id))
    else
      error_render(:new)
    end
  end

  def edit; end

  def update
    if @work.update(work_params)
      success_redirect("Changes saved", work_path(@work.id))
    else
      error_render(:edit)
    end
  end

  def destroy
    unless @work.nil?
      @work.votes.each do |vote|
        vote.destroy
      end

      deleted_work = @work.destroy

      success_redirect("#{deleted_work.title} deleted", root_path)
    end
  end

  def upvote
    user = User.find_by(id: session[:user_id])

    if user.nil?
      error_redirect("A problem occurred: You must log in to vote")
    elsif user.eligible_to_vote?(@work)
      vote = Vote.new(work: @work, user: user, date: Date.today)

      if vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      else
        error_redirect("Error: Could not process vote")
      end
    else # user logged in but ineligible to vote
      error_redirect("A problem occurred: You've already voted on this work")
    end
  end

  private

    def work_params
      return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    end

    def find_work
      @work = Work.find_by(id: params[:id].to_i)

      if @work.nil?
        flash.now[:warning] = "Cannot find the work"
        render :notfound, status: :not_found
      end
    end

    def success_redirect(message, path)
      flash[:success] = message
      redirect_to path
    end

    def error_redirect(message)
      find_work
      flash[:error] = message

      @work.errors.messages.each do |field, messages|
        flash[field] = messages
      end

      redirect_back(fallback_location: root_path)
    end

    def error_render(view)
      find_work
      flash.now[:error] = "Error: Work not saved"

      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render view
    end
end
