class ApplicationController < ActionController::Base
    before_action :set_cache_headers # tells the method to run first every time
    before_action :find_user # tells the method to run first every time

    private

    def find_user
      @current_user = User.find_by(id: session[:user_id])
    end

    def set_cache_headers
      response.headers["Cache-Control"] = "no-cache, no-store"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
end
