class UsersController < ApplicationController
  before_action :exit_current_user?, only: [:profile, :show]

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
