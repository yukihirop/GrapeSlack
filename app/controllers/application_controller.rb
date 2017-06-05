class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :deny_anonymous

  def deny_anonymous
    redirect_to root_path, notice: I18n.t('commons.required_login') unless user_signed_in?
  end

  def you_look_user
    @you_look_user = User.find_by(nickname: params[:nickname])
  end

  helper_method :you_look_user

end
