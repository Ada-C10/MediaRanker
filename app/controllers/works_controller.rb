class WorksController < ApplicationController
  def index
    @works = (Work.all).sort_by do |work|
      work.category
    end
  end
end
