class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :deny_anonymous

  def deny_anonymous
    redirect_to root_path, notice: I18n.t('commons.required_login') unless user_signed_in?
  end

end
