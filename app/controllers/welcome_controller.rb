class WelcomeController < ApplicationController
  def index
    @works = Works.all
    # Does not know what works are :(
    # Do I need to figure out the seed issue/seupt the controllers the rest of the way?
    # Does it need a relationship to works? 
  end
end
