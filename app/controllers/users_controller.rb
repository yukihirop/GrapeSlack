class UsersController < ApplicationController
  skip_before_action :exit_current_user?, only: [:index]

  def index
  end

  def show
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def profile
    unless user_signed_in?
      redirect_to user_profile_path
    end
  end

end
