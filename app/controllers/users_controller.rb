class UsersController < ApplicationController

  def index
  end

  def create
    check_existed_user = User.find(params[:username])

    if check_existed_user

    end
  end
end
