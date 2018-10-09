class UsersController < ApplicationController
  def index
    @users = (User.all).sort_by do |user|
      user.id
    end
  end
end
