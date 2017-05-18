class UsersController < ApplicationController

  def index
  end

  def show
    unless user_signed_in?
      redirect_to root_path
    end
  end

end
