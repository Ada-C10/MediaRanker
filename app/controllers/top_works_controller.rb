class TopWorksController < ApplicationController

  before_action :find_logged_in_user

  def index
    @top = Work.get_top_work
    #
    # @top_ten = Work.get_top_list
  end
end
