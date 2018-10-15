class WorksController < ApplicationController
  def index
      @albums = Work.where(category: "album")
      @movies = Work.where(category: "movie")
      @books = Work.where(category: "book")#paginate(page: params[:page], per_page: 10)

      #@works = Work.joins(:votes).select('works.*, count(vote.id)as vote_count').group('works.id').order(:title)
    end

    def show
      id = params[:id]
      @work = Work.find_by(id:id)
    end

    def new
        @work = Work.new
      end

      def update
        if @work && @work.update(work_params)
        redirect_to work_path(@work.id)
      elsif @work
          render :edit
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

  def destroy
    work = Work.find_by(id: params[:id].to_i)
    work.destroy
    redirect_to works_path
  end


  private

def work_params
  return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
end

  end
