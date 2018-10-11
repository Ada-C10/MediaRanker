class ApplicationController < ActionController::Base
  before_action :set_cache_headers
  before_action :find_user

  private

    def find_user
      @current_user = User.find_by(id: session[:user_id])
      # user id will be nil if not logged in or whole author model if they are logged in
    end

    def set_cache_headers
      response.headers["Cache-Control"] = "no-cache, no-store"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
end
