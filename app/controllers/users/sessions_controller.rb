class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :deny_anonymous, :only => [:new]
  skip_before_action :require_no_authentication, :only => [ :new, :destroy]

  # GET /resource/sign_in
  def new
    if user_signed_in?
      flash[:notice] = I18n.t 'devise.sessions.signed_in'
      redirect_to user_info_path
    else
      redirect_to user_slack_omniauth_authorize_path
    end
  end

  def create

  end

  # DELETE /resource/sign_out
  def destroy
    sign_out
    flash[:notice] = I18n.t 'devise.sessions.signed_out'
    redirect_to root_path
  end

end
