class WorksController < ApplicationController

  before_action :find_work, only: [:show, :edit, :update, :destroy]

    def index
      @books = Work.works_by_category("book")
      @albums = Work.works_by_category("album")
      @movies = Work.works_by_category("movie")
    end


    def new
      if params[:user_id]
        user = User.find_by(id: params[:user_id])
        # How do we handle if the author is not found?
        #  If the author is not found, we would have a conditional to check
        # that the author was found.
        # Redirect to a 404 page
        # Redirect to another existing page (the home page?) (new author form?)
        # Show an error message saying that the author was not found
        @work = user.works.new
      else
        @work = Work.new
      end
    end

    def create
      @work = Work.new(work_params)
      if @work.save
        redirect_to works_path
      else
        render :new
      end
    end

    def show
      @work = Work.find(params[:id])
      @votes = Vote.votes_by_work(@work.id)
    end

    def edit
    end

    def update
      if @work.update(work_params)
        flash[:success] = "Successfully updated media \"#{@work.title}\""
        redirect_to work_path(@work.id)
      else
        flash.now[:error] = "Invalid media data"
        render(:edit, status: :bad_request)
      end
    end

    def destroy
      if @current_user == session[:user_id]
            @work.destroy

        flash[:success] = "Successfully destroyed book \"#{@work.title}\""
        redirect_to works_path

      else
        flash[:error] = "You must be logged in as a book's author in order to delete it!"

        redirect_back(fallback_location: root_path)
      end
    end

    def upvote
    end



    private

    def work_params
      return params.require(:work).permit(
        :title,
        :creator,
        :category,
        :description,
        :publication_year,
        :user_id
      )
    end

    def find_work
      @work = Work.find_by(id: params[:id])
    end
end
