class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :exit_current_user?

  def exit_current_user?
    redirect_to root_path, notice: I18n.t('commons.required_login') unless current_user
  end

end
