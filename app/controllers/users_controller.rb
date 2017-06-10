class UsersController < ApplicationController
  skip_before_action :deny_anonymous, only: [:index]

  def index
  end

  def show
  end

  def profile
  end

end
