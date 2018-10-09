class SessionsController < ApplicationController
  def login
  end

  def new
    @user = User.new
  end

  def destroy
  end
end
