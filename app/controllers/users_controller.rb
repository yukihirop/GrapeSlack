class UsersController < ApplicationController
  skip_before_action :deny_anonymous, only: [:index]

  def index
  end

  def show
    @users = User.all.page(params[:page])
  end

  def profile
  end

end
