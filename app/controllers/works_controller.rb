class WorksController < ApplicationController

  def index
      @works = Work.all.order(:title)
    end

    def show
        id = params[:id].to_i
        @work = Work.find_by(id: id)
        
      end
end
