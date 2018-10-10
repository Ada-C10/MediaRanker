class WorksController < ApplicationController

  def index
    @works = Work.all.order(:title)
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
    end

    def show
        id = params[:id].to_i
        @work = Work.find_by(id: id)
      end

      def edit
        @work = Work.find(params[:id].to_i)
      end

      def update
        @work = Work.find_by(id: params[:id].to_i)
        if @work.update(work_params)
          redirect_to work_path(@work.id)
        else
          render :edit
        end
      end

      def new
        @work = Work.new
      end

      def create
        @work = Work.new(work_params)
        if @work.save
          redirect_to work_path(@work.id)
        else
          render :new
        end
      end

      def destroy
        work = Work.find_by(id: params[:id].to_i)
        @work = work.destroy
        redirect_to works_path
      end

      def upvote
        work = Work.find_by(id: params[:id].to_i)
        user = User.find_by(id: session[:user_id])
        if ![:user_id]
          flash.now[:error] = "A problem occured, you must log in to upvote"
        else
          vote = Vote.new(work: work, user: user)
          vote.save
        end
        redirect_back fallback_location: root_path
      end



      private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication_year, :description, :category)
  end
end
