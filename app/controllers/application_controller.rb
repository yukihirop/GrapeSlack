class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :deny_anonymous
  before_action :set_request

  def set_request
    Thread.current[:request] = request
  end

  def deny_anonymous
    redirect_to root_path, notice: I18n.t('commons.required_login') unless current_user
  end

end
