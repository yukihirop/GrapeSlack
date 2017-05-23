class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def exit_current_user?
    head :not_found unless current_user
  end
  helper_method :exit_current_user?

end
