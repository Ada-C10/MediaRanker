class WorksController < ApplicationController
  def index
    @works = (Work.all).sort_by do |work|
      work.id
    end
  end
