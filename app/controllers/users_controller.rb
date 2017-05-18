class UsersController < ApplicationController

  def index
  end

  def show
    unless user_signed_in?
      raise Exception
    end
  end

end
