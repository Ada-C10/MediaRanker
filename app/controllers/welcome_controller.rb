class WelcomeController < ApplicationController
  def index
    @works = Works.all 
  end
end
